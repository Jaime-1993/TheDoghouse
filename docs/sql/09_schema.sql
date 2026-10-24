-- The Doghouse — PostgreSQL schema (v1)
-- Apply on a clean database (Neon or local). Seed data is loaded in implementation deliveries, not here.
-- Money: INTEGER cents. Time: TIMESTAMPTZ. PKs: UUID.

CREATE EXTENSION IF NOT EXISTS pgcrypto;
CREATE EXTENSION IF NOT EXISTS citext;

-- ---------------------------------------------------------------------------
-- Enums
-- ---------------------------------------------------------------------------

CREATE TYPE content_type AS ENUM (
  'video',
  'bundle',
  'calculator_complete'
);

CREATE TYPE purchase_status AS ENUM (
  'pending',
  'completed',
  'failed'
);

CREATE TYPE discount_type AS ENUM (
  'none',
  'code',
  'auto_campaign'
);

CREATE TYPE entitlement_origin AS ENUM (
  'purchase',
  'bundle',
  'grant'
);

-- ---------------------------------------------------------------------------
-- Users
-- ---------------------------------------------------------------------------

CREATE TABLE users (
  id            UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  email         CITEXT NOT NULL UNIQUE,
  name          VARCHAR(100),
  google_id     VARCHAR(255) UNIQUE,
  facebook_id   VARCHAR(255) UNIQUE,
  registered_at TIMESTAMPTZ NOT NULL DEFAULT now(),
  last_access   TIMESTAMPTZ
);

-- ---------------------------------------------------------------------------
-- Auth (session JWT is NOT stored; cookie/Bearer only)
-- ---------------------------------------------------------------------------

CREATE TABLE magic_links (
  id         UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  user_id    UUID REFERENCES users (id) ON DELETE SET NULL,
  email      CITEXT NOT NULL,
  token_hash VARCHAR(255) NOT NULL UNIQUE,
  created_at TIMESTAMPTZ NOT NULL DEFAULT now(),
  expires_at TIMESTAMPTZ NOT NULL,
  used       BOOLEAN NOT NULL DEFAULT FALSE,
  used_at    TIMESTAMPTZ
);

CREATE INDEX magic_links_email_created_idx
  ON magic_links (email, created_at DESC);

-- Seamless fallback (architecture D3): short-lived one-time code
CREATE TABLE auth_one_time_codes (
  id         UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  user_id    UUID NOT NULL REFERENCES users (id) ON DELETE CASCADE,
  code_hash  VARCHAR(255) NOT NULL UNIQUE,
  created_at TIMESTAMPTZ NOT NULL DEFAULT now(),
  expires_at TIMESTAMPTZ NOT NULL,
  used       BOOLEAN NOT NULL DEFAULT FALSE,
  used_at    TIMESTAMPTZ
);

CREATE INDEX auth_one_time_codes_user_idx
  ON auth_one_time_codes (user_id, created_at DESC);

-- ---------------------------------------------------------------------------
-- Catalogue
-- ---------------------------------------------------------------------------

CREATE TABLE breeds (
  id          UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  name        VARCHAR(100) NOT NULL UNIQUE,
  description TEXT,
  image_url   VARCHAR(500),
  created_at  TIMESTAMPTZ NOT NULL DEFAULT now()
);

CREATE TABLE calculator_data (
  id         UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  breed_id   UUID NOT NULL UNIQUE REFERENCES breeds (id) ON DELETE CASCADE,
  data       JSONB NOT NULL,
  updated_at TIMESTAMPTZ NOT NULL DEFAULT now()
);

CREATE TABLE contents (
  id                   UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  breed_id             UUID REFERENCES breeds (id) ON DELETE SET NULL,
  type                 content_type NOT NULL,
  sku                  VARCHAR(100) NOT NULL UNIQUE,
  title                VARCHAR(200) NOT NULL,
  description          TEXT,
  price_cents          INTEGER NOT NULL CHECK (price_cents >= 0),
  is_free              BOOLEAN NOT NULL DEFAULT FALSE,
  media_url            VARCHAR(500),
  created_at           TIMESTAMPTZ NOT NULL DEFAULT now(),
  CONSTRAINT contents_video_breed_chk CHECK (
    type <> 'video' OR breed_id IS NOT NULL
  ),
  CONSTRAINT contents_calculator_no_breed_chk CHECK (
    type <> 'calculator_complete' OR breed_id IS NULL
  )
);

CREATE INDEX contents_type_idx ON contents (type);
CREATE INDEX contents_breed_idx ON contents (breed_id);

-- Workshop bundles only (RN-16 / RF-54): parent = bundle, children = video.
-- Cross-catalogue packages (calculator + workshops) are out of scope for v1.
CREATE TABLE bundle_items (
  bundle_id  UUID NOT NULL REFERENCES contents (id) ON DELETE CASCADE,
  content_id UUID NOT NULL REFERENCES contents (id) ON DELETE CASCADE,
  PRIMARY KEY (bundle_id, content_id),
  CONSTRAINT bundle_items_not_self CHECK (bundle_id <> content_id)
);

-- Enforce types across tables (plain CHECK cannot see other rows).
CREATE OR REPLACE FUNCTION bundle_items_types_enforce()
RETURNS trigger
LANGUAGE plpgsql
AS $$
DECLARE
  parent_type content_type;
  child_type  content_type;
BEGIN
  SELECT type INTO parent_type FROM contents WHERE id = NEW.bundle_id;
  SELECT type INTO child_type  FROM contents WHERE id = NEW.content_id;

  IF parent_type IS DISTINCT FROM 'bundle' THEN
    RAISE EXCEPTION
      'bundle_items.bundle_id (%) must reference contents.type = bundle',
      NEW.bundle_id;
  END IF;

  IF child_type IS DISTINCT FROM 'video' THEN
    RAISE EXCEPTION
      'bundle_items.content_id (%) must reference contents.type = video (workshop catalogue only)',
      NEW.content_id;
  END IF;

  RETURN NEW;
END;
$$;

CREATE TRIGGER bundle_items_types_trg
  BEFORE INSERT OR UPDATE ON bundle_items
  FOR EACH ROW
  EXECUTE FUNCTION bundle_items_types_enforce();

-- Guard type changes on contents that already participate in bundle_items.
CREATE OR REPLACE FUNCTION contents_bundle_role_guard()
RETURNS trigger
LANGUAGE plpgsql
AS $$
BEGIN
  IF OLD.type IS DISTINCT FROM NEW.type THEN
    IF EXISTS (SELECT 1 FROM bundle_items WHERE bundle_id = NEW.id)
       AND NEW.type IS DISTINCT FROM 'bundle' THEN
      RAISE EXCEPTION
        'cannot change type of content % away from bundle while it is a bundle parent',
        NEW.id;
    END IF;

    IF EXISTS (SELECT 1 FROM bundle_items WHERE content_id = NEW.id)
       AND NEW.type IS DISTINCT FROM 'video' THEN
      RAISE EXCEPTION
        'cannot change type of content % away from video while it is a bundle child',
        NEW.id;
    END IF;
  END IF;

  RETURN NEW;
END;
$$;

CREATE TRIGGER contents_bundle_role_trg
  BEFORE UPDATE OF type ON contents
  FOR EACH ROW
  EXECUTE FUNCTION contents_bundle_role_guard();

-- ---------------------------------------------------------------------------
-- Commerce
-- ---------------------------------------------------------------------------

CREATE TABLE purchases (
  id                      UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  user_id                 UUID NOT NULL REFERENCES users (id) ON DELETE CASCADE,
  content_id              UUID NOT NULL REFERENCES contents (id),
  status                  purchase_status NOT NULL DEFAULT 'pending',
  catalogue_price_cents   INTEGER NOT NULL CHECK (catalogue_price_cents >= 0),
  discount_percent        INTEGER NOT NULL DEFAULT 0 CHECK (discount_percent >= 0 AND discount_percent <= 100),
  discount_type           discount_type NOT NULL DEFAULT 'none',
  promo_code_id           UUID,
  campaign_id             UUID,
  amount_paid_cents       INTEGER NOT NULL CHECK (amount_paid_cents >= 0),
  currency                CHAR(3) NOT NULL DEFAULT 'EUR',
  stripe_checkout_session_id VARCHAR(255) UNIQUE,
  stripe_payment_intent_id   VARCHAR(255) UNIQUE,
  created_at              TIMESTAMPTZ NOT NULL DEFAULT now(),
  completed_at            TIMESTAMPTZ,
  CONSTRAINT purchases_discount_snapshot_chk CHECK (
    (
      discount_type = 'none'
      AND promo_code_id IS NULL
      AND campaign_id IS NULL
      AND discount_percent = 0
    )
    OR (
      discount_type = 'code'
      AND promo_code_id IS NOT NULL
      AND campaign_id IS NULL
    )
    OR (
      discount_type = 'auto_campaign'
      AND campaign_id IS NOT NULL
      AND promo_code_id IS NULL
    )
  )
);

CREATE INDEX purchases_user_idx ON purchases (user_id, created_at DESC);
CREATE INDEX purchases_user_status_idx ON purchases (user_id, status);

CREATE TABLE entitlements (
  id          UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  user_id     UUID NOT NULL REFERENCES users (id) ON DELETE CASCADE,
  content_id  UUID NOT NULL REFERENCES contents (id) ON DELETE CASCADE,
  purchase_id UUID REFERENCES purchases (id) ON DELETE SET NULL,
  origin      entitlement_origin NOT NULL,
  created_at  TIMESTAMPTZ NOT NULL DEFAULT now(),
  UNIQUE (user_id, content_id),
  CONSTRAINT entitlements_purchase_origin_chk CHECK (
    (origin IN ('purchase', 'bundle') AND purchase_id IS NOT NULL)
    OR (origin = 'grant' AND purchase_id IS NULL)
  )
);

CREATE INDEX entitlements_user_idx ON entitlements (user_id);

CREATE TABLE invoices (
  id                 UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  purchase_id        UUID NOT NULL UNIQUE REFERENCES purchases (id) ON DELETE CASCADE,
  moloni_document_id VARCHAR(255),
  pdf_url            VARCHAR(500),
  amount_cents       INTEGER NOT NULL CHECK (amount_cents > 0),
  issued_at          TIMESTAMPTZ NOT NULL DEFAULT now(),
  fiscal_data        JSONB
);

-- ---------------------------------------------------------------------------
-- Promotions (script/console; no admin UI in v1)
-- ---------------------------------------------------------------------------

CREATE TABLE discount_campaigns (
  id               UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  name             VARCHAR(200) NOT NULL,
  percent          INTEGER NOT NULL CHECK (percent >= 0 AND percent <= 100),
  starts_at        TIMESTAMPTZ NOT NULL,
  ends_at          TIMESTAMPTZ NOT NULL,
  active           BOOLEAN NOT NULL DEFAULT TRUE,
  created_at       TIMESTAMPTZ NOT NULL DEFAULT now(),
  CONSTRAINT discount_campaigns_window_chk CHECK (ends_at > starts_at)
);

CREATE TABLE discount_campaign_contents (
  campaign_id UUID NOT NULL REFERENCES discount_campaigns (id) ON DELETE CASCADE,
  content_id  UUID NOT NULL REFERENCES contents (id) ON DELETE CASCADE,
  PRIMARY KEY (campaign_id, content_id)
);

CREATE TABLE promo_codes (
  id               UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  code             CITEXT NOT NULL UNIQUE,
  percent          INTEGER NOT NULL CHECK (percent >= 0 AND percent <= 100),
  starts_at        TIMESTAMPTZ NOT NULL,
  ends_at          TIMESTAMPTZ NOT NULL,
  max_redemptions  INTEGER CHECK (max_redemptions IS NULL OR max_redemptions >= 1),
  redemption_count INTEGER NOT NULL DEFAULT 0 CHECK (redemption_count >= 0),
  active           BOOLEAN NOT NULL DEFAULT TRUE,
  created_at       TIMESTAMPTZ NOT NULL DEFAULT now(),
  CONSTRAINT promo_codes_window_chk CHECK (ends_at > starts_at)
);

CREATE TABLE promo_code_contents (
  promo_code_id UUID NOT NULL REFERENCES promo_codes (id) ON DELETE CASCADE,
  content_id    UUID NOT NULL REFERENCES contents (id) ON DELETE CASCADE,
  PRIMARY KEY (promo_code_id, content_id)
);

CREATE TABLE promo_code_redemptions (
  id            UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  promo_code_id UUID NOT NULL REFERENCES promo_codes (id) ON DELETE CASCADE,
  purchase_id   UUID NOT NULL UNIQUE REFERENCES purchases (id) ON DELETE CASCADE,
  created_at    TIMESTAMPTZ NOT NULL DEFAULT now()
);

ALTER TABLE purchases
  ADD CONSTRAINT purchases_promo_code_fk
    FOREIGN KEY (promo_code_id) REFERENCES promo_codes (id) ON DELETE SET NULL;

ALTER TABLE purchases
  ADD CONSTRAINT purchases_campaign_fk
    FOREIGN KEY (campaign_id) REFERENCES discount_campaigns (id) ON DELETE SET NULL;

-- ---------------------------------------------------------------------------
-- Stripe idempotency
-- ---------------------------------------------------------------------------

CREATE TABLE stripe_webhook_events (
  event_id    VARCHAR(255) PRIMARY KEY,
  received_at TIMESTAMPTZ NOT NULL DEFAULT now(),
  payload     JSONB
);

CREATE TABLE checkout_idempotency_keys (
  user_id     UUID NOT NULL REFERENCES users (id) ON DELETE CASCADE,
  key         VARCHAR(128) NOT NULL,
  purchase_id UUID REFERENCES purchases (id) ON DELETE SET NULL,
  response    JSONB,
  created_at  TIMESTAMPTZ NOT NULL DEFAULT now(),
  expires_at  TIMESTAMPTZ NOT NULL,
  PRIMARY KEY (user_id, key)
);

-- ---------------------------------------------------------------------------
-- Maps cache + optional calculator history
-- ---------------------------------------------------------------------------

CREATE TABLE overpass_cache (
  id         UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  cache_key  VARCHAR(255) NOT NULL UNIQUE,
  data       JSONB NOT NULL,
  created_at TIMESTAMPTZ NOT NULL DEFAULT now(),
  expires_at TIMESTAMPTZ NOT NULL
);

CREATE INDEX overpass_cache_expires_idx ON overpass_cache (expires_at);

CREATE TABLE weight_history (
  id           UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  user_id      UUID NOT NULL REFERENCES users (id) ON DELETE CASCADE,
  breed_id     UUID NOT NULL REFERENCES breeds (id) ON DELETE CASCADE,
  age_months   INTEGER NOT NULL CHECK (age_months >= 0),
  result       JSONB NOT NULL,
  recorded_at  TIMESTAMPTZ NOT NULL DEFAULT now()
);

CREATE INDEX weight_history_user_idx ON weight_history (user_id, recorded_at DESC);
