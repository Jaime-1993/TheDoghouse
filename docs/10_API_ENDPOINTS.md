# API Endpoints – _The Doghouse_

## 1. Introduction

HTTP contracts for the **Go** API (Render) that implement authentication, catalogue access, calculator, hotels map, checkout, Stripe webhooks, and invoices — aligned with [`08_ARCHITECTURE.md`](08_ARCHITECTURE.md), [`09_DATABASE.md`](09_DATABASE.md), and the relevant requirements in [`07_REQUIREMENTS.md`](07_REQUIREMENTS.md).

**Living document (with closed rules):** business rules for auth, session transport, checkout, HTTP errors, and idempotency are **closed** here for the planned first version. Screen layouts, exact field aggregates, and minor path/payload tweaks may still be refined during implementation when code proves a need. Changes that alter frozen RN/RF must propagate to `07` / `08` / `09`.

**Principles:**

- JSON field names and path segments in **English**, aligned with the schema in [`09_DATABASE.md`](09_DATABASE.md).
- Single **JWT**, validity **7 days**, no refresh-token store (**D1**, **DB-2**).
- **Web** (static site + Flutter Web): session **cookie** `HttpOnly` + `Secure` (+ `SameSite=Lax` unless a documented exception). **Native iOS/Android:** `Authorization: Bearer` only (**D2**).
- No Apple/Google IAP for these SKUs; Stripe **sandbox** + Moloni **sandbox** (**D10**, **RF-56…RF-57**).
- Backend is authoritative (**D13**, **RNF-13**): UI helps; the API revalidates session, SKUs, entitlements, and discounts.
- **No `/v1` and no `/api` prefix** — see §1.1.
- **Request granularity** — see §2.0: small endpoints by default; one home aggregate for the signed-in landing screen.

**Base URL:** the Render Web Service host (exact hostname from deploy env). Paths below are relative to that base (e.g. `POST /auth/magic-link`).

### 1.0. Closed API decisions (this revision)

| # | Topic | Decision |
| - | ----- | -------- |
| **API-1** | Paths | No `/v1`, no `/api` prefix |
| **API-2** | Granularity | Small endpoints by default; one aggregate `GET /me/home` |
| **API-3** | Errors | `{ "error": { "code", "message" } }`; other user’s resource → **404** |
| **API-4** | Media | Playback `media_url` only when `access_state` ∈ {`free`, `owned`}; thumbnail may be open to signed-in members |
| **API-5** | Discounts | §9.0: auto campaign without code; non-stack; higher % wins; tie → code (**RF-66**) |
| **API-6** | Free SKUs | Not checkout targets — **409** `not_purchasable` |
| **API-7** | Webhook | Insert `event_id` first (unique) → conflict = no-op |
| **API-8** | Emails | Welcome (**RF-19**) and purchase confirmation (**RF-70**) as side effects, not routes |

### 1.1. Why not `/v1` or `/api`

| Option | Purpose | In this project |
| ------ | ------- | --------------- |
| Prefix `/v1`, `/v2`… | Run incompatible API versions in parallel | Unnecessary for a solo first version on one host |
| Prefix `/api` | Separate API routes from a static site on the **same** host | API lives on **Render**; static site / Flutter Web on **Vercel** — the host already marks the API space |
| Resource paths only | `POST /auth/…`, `GET /me/…` | **Official choice** for this document |

If a large breaking change ships later with clients in the wild, versioning (path, header, or host) can be revisited. Until then: clean paths and this living contract.

---

## 2. Conventions

### 2.0. Request granularity (closed)

| Situation | Style | Example |
| --------- | ----- | ------- |
| Screen that needs **several** resources at once (signed-in home / members landing) | **One aggregate** | `GET /me/home` |
| Screen or action that needs **one** thing | **Small, specific** request | `GET /purchases/{id}`, `POST /auth/logout` |
| Write / side effect | Always **specific** (never hidden inside a giant GET) | checkout, webhook, magic link |

**Rules:**

1. There is no single “give me the whole product” endpoint for the entire app.
2. The Flutter client **must not** build the first authenticated screen with a chain of 4–5 GETs (especially painful after a Render cold start). Use the home aggregate for that screen.
3. If a later screen only needs one slice (e.g. invoices only), use the **small** endpoint — do not force the aggregate.
4. On checkout, the API **ignores** client-invented prices/discounts and **recalculates** (§9, **D13**, **RF-66**).
5. Aggregates **compose** the same data as the small endpoints; business logic lives in one Go service layer, not duplicated ad hoc in handlers.

### 2.1. Authentication

| Mechanism | Use |
| --------- | --- |
| Session cookie (`HttpOnly`, `Secure`, `SameSite=Lax` unless documented otherwise) | Static site + Flutter Web (**D2**, **D3**) |
| `Authorization: Bearer <jwt>` | Native iOS/Android (**D2**) |
| Neither | Public auth routes, Stripe webhook, `GET /health` |

Cookie **name** and path are an implementation detail; behaviour above is normative. After magic-link / OAuth / OTC exchange, the API sets the session cookie for Web clients. Native clients receive the JWT in the JSON body and store it securely on device.

**CORS:** allowlist Vercel origins used by the site and Flutter Web (production and preview as needed). Exact origin strings live in deploy config; the principle is normative here.

### 2.2. Error format

```json
{
  "error": {
    "code": "already_owned",
    "message": "You already have lifetime access to this item."
  }
}
```

| HTTP | When |
| ---- | ---- |
| 400 | Malformed request (bad types, missing required fields) |
| 401 | Missing or invalid session |
| 403 | Authenticated but action forbidden (rare; prefer **404** for another user’s resource) |
| 404 | Resource missing, inactive SKU, or resource not owned by the caller |
| 409 | Business conflict (re-purchase, bundle already complete) |
| 422 | Business rule on input (expired promo, wrong product for code, invalid/expired magic link) |
| 429 | Rate limit (magic-link requests) |
| 502 / 503 | Upstream (Stripe/email) or prolonged cold start |

Stable `error.code` values used in this document (non-exhaustive): `already_owned`, `bundle_complete`, `not_purchasable`, `promo_invalid`, `promo_expired`, `promo_exhausted`, `promo_wrong_product`, `magic_link_invalid`, `magic_link_expired`, `magic_link_used`, `otc_invalid`, `otc_expired`, `otc_used`.

### 2.3. Money and discounts

- Amounts in **integer cents**.
- `discount_type`: `none` \| `code` \| `auto_campaign` (aligned with **RN-28** / schema enums).

### 2.4. Identifiers

- Internal resources: `UUID`.
- Stable catalogue identity: `sku` (e.g. `calculator-complete`).

### 2.5. Frontend helps; backend decides (**D13**, **RNF-13**)

| Layer | Role |
| ----- | ---- |
| Frontend | Forms, masks, hide buy CTA when already owned — **UX only** |
| Backend | Authn/authz, entitlements, prices, discounts, ownership |

Sensitive handlers must: validate session (or Stripe signature); validate body; re-apply business rules in the database; never trust client `amount_paid_cents` / `discount_type` on checkout; return **404** for another user’s resources.

---

## 3. Product question → endpoint

| Product question | Endpoint / mechanism |
| ---------------- | -------------------- |
| Bootstrap signed-in home | `GET /me/home` (**aggregate**) |
| Profile only | `GET /me` / `PATCH /me` |
| What do I own? | `GET /me/entitlements` or via home |
| Catalogue + access state | `GET /contents` / `GET /contents/{sku}` |
| Free vs complete calculator | `POST /calculator/evaluate` |
| Hotels in viewport / geocode | `GET /hotels`, `GET /geocode` |
| Price / discount preview | `POST /checkout/quote` |
| Start purchase | `POST /checkout/purchases` |
| Poll purchase after Stripe | `GET /purchases/{id}` |
| My invoices | `GET /me/invoices` |
| Stripe webhook | `POST /webhooks/stripe` |
| Seamless fallback (Web) | `POST /auth/one-time-code` + `/exchange` |
| Ops campaigns / codes | SQL / console — not public API (**RF-58**) |

---

## 4. Auth

### 4.1. `POST /auth/magic-link`

**Auth:** public. **RF-14**, **RF-15**.

**Request:** `{ "email": "owner@example.com" }`  
**Response 202:** `{ "ok": true }` — always generic (do not reveal whether the email exists).  
Effect: store hashed magic link (15 minutes, single use); send email.

**Rate limit:** max **5 requests / hour / email** (and by IP if useful). Above → **429** with a generic message.

### 4.2. `POST /auth/magic-link/consume`

**Request:** `{ "token": "<plaintext_from_email>" }`

**Response 200 (common fields):**

```json
{
  "user": {
    "id": "…",
    "email": "owner@example.com",
    "name": null,
    "created_now": true
  },
  "expires_at": "2026-11-10T12:00:00Z"
}
```

| Client | Session delivery |
| ------ | ---------------- |
| **Web** | `Set-Cookie` with the JWT; JSON may omit `token` |
| **Native** | JSON includes `"token": "<jwt>"` (Bearer thereafter) |

`created_now: true` = first successful auth for that email. When `created_now` is true, the API **may** trigger a welcome email (**RF-19**) — side effect only; no dedicated endpoint.

**Errors:** 422 `magic_link_invalid` \| `magic_link_expired` \| `magic_link_used`.

### 4.3. `POST /auth/google` and `POST /auth/facebook`

**Auth:** public. **RF-11**, **D4**.

| Client | Typical body |
| ------ | ------------ |
| Native | `{ "id_token": "<provider_token>" }` — API verifies with the provider |
| Web | Browser OAuth redirect into an API callback (implementation detail); end state same as §4.2 |

Creates/updates `users` by email / `google_id` / `facebook_id`. Response shape same as §4.2 (cookie vs `token`).

### 4.4. `POST /auth/logout`

**Auth:** session required (cookie or Bearer).

- **Web:** clear session cookie → **204**.
- **Native:** client discards JWT locally; API returns **204** (no server-side session/refresh store to revoke — **D1**, **DB-2**).

### 4.5. Seamless fallback — one-time code (**D3**, **RF-20**, **RF-21**)

Primary seamless path is the **shared session cookie** on Vercel. Use OTC only if that cannot be configured.

| Method | Path | Notes |
| ------ | ---- | ----- |
| `POST` | `/auth/one-time-code` | Authenticated; creates code; **TTL = 5 minutes**; single use; `{ "code": "…", "expires_at": "…" }` |
| `POST` | `/auth/one-time-code/exchange` | Public; `{ "code": "…" }` → session as §4.2 |

**Never** put the long-lived JWT in the query string.  
**Errors on exchange:** 422 `otc_invalid` \| `otc_expired` \| `otc_used`.

---

## 5. Me / home / entitlements

### 5.1. `GET /me`

**Auth:** required. Small profile payload: `id`, `email`, `name`.

### 5.2. `PATCH /me`

**Request:** `{ "name": "Alex" }` (and other profile fields allowed later). Returns updated user.

### 5.3. `GET /me/entitlements`

Small list of paid lifetime unlocks:

```json
{
  "entitlements": [
    {
      "sku": "calculator-complete",
      "title": "…",
      "origin": "purchase",
      "granted_at": "…"
    }
  ]
}
```

Free intros / free calculator do **not** appear here and do **not** require a row (**DB-4**).

### 5.4. `GET /me/home` (aggregate)

**Auth:** required. **One** request for the first signed-in members screen (avoids N serial GETs after cold start).

Composes the same data as `GET /me` + `GET /me/entitlements` + active catalogue with `access_state` (as in §6, including the **media URL gate**). **Does not** include invoices (use §11).

```json
{
  "user": { "id": "…", "email": "…", "name": "Alex" },
  "entitlements": [ { "sku": "calculator-complete", "origin": "purchase", "granted_at": "…" } ],
  "contents": [
    {
      "sku": "calculator-complete",
      "type": "calculator_complete",
      "title": "…",
      "price_cents": 990,
      "currency": "EUR",
      "access_state": "owned"
    }
  ]
}
```

**When to use:** open members home / “what I have / what I can buy”.  
**When not to use:** invoice-only screen, purchase poll, map viewport, etc.

---

## 6. Catalogue

### 6.1. `GET /contents`

**Auth:** required (visitors do not use members catalogue — **RF-23**).  
Optional query: `?type=video|bundle|calculator_complete` and/or breed filter as needed.

Each item includes `access_state` for the caller:

| `access_state` | UI meaning |
| -------------- | ---------- |
| `none` | Show purchase CTA (paid SKU) |
| `owned` | Already has lifetime access — **no** buy CTA (**RF-64**) |
| `bundle_partial` | Bundle SKU: owns some child videos; CTA at **full** catalogue price + copy (**RF-65**) |
| `bundle_complete` | Owns every child video — treat as owned (**RF-64**) |
| `free` | Free intro / free-tier content — no purchase |

For `bundle_partial`, include `owned_skus` and `missing_skus` (video SKUs only — **DB-11**, **RF-54**).

### 6.1.1. Media URL gate (**RF-26**, **D13**)

Workshop (and any playable) content may expose URLs. **Playback** must not leak paid media to members who have not unlocked it:

| Field | When present in JSON |
| ----- | -------------------- |
| `media_url` (playback) | Only if `access_state` ∈ {`free`, `owned`} for **that** SKU. Otherwise **omit** or `null` |
| `thumbnail_url` (optional) | May be returned to any signed-in member for browsing/CTA |

The same gate applies to catalogue rows inside `GET /me/home`. Buying one item never silently unlocks unrelated media (**RF-26**). There is no streaming/CDN proxy in v1 — when `media_url` is present it is an external URL (**RF-42**).

### 6.2. `GET /contents/{sku}`

Detail + same `access_state` and media gate. **404** if SKU missing/inactive.

### 6.3. `GET /breeds` and `GET /breeds/{id}`

Breed list/detail for calculator and workshops organisation (**RF-35**). Auth required.

---

## 7. Calculator

### 7.1. `POST /calculator/evaluate`

**Auth:** required. **RF-28…RF-32**.

**Request:**

```json
{
  "breed_id": "…",
  "age_months": 6
}
```

**Behaviour:** API loads breed calculator data; if the user has the `calculator_complete` entitlement, return the **rich** payload; otherwise return the **approximate** free result plus a clear upsell hint (`upsell: true` / CTA metadata). One path — backend decides detail level (**D13**).

Persisting runs to `weight_history` is **out of the v1 public contract** (schema exists — **DB-10**, **RF-34** Optional).

---

## 8. Hotels map

### 8.1. `GET /hotels`

**Auth:** required. **RF-43…RF-48**.

Query: viewport bbox (e.g. `south`, `west`, `north`, `east`) — **required**; no unbounded global dump (**RF-46**).  
API queries Overpass (pet-friendly tags), applies **24 h** cache (**RF-47**, **DB-9**). Cache HIT/MISS is transparent to the client.

Response: list of hotels with name/address/contact when available; enough data for “open in maps” on the client (**RF-49**).

### 8.2. `GET /geocode`

**Auth:** required. **RF-44**.  
Query: `q` (text). Proxies Nominatim (or equivalent); returns coordinates for map centering. Declining device geolocation still allows this path.

---

## 9. Checkout

**Model (closed):** each purchase targets **one** catalogue SKU (`video`, `bundle`, or `calculator_complete`). That SKU is the discount target (**RN-26**). If it is a workshop **bundle**, the API grants missing **video** entitlements only (**RF-65**, **DB-11**). The API does **not** accept an arbitrary list of loose SKUs in one checkout in v1.

Free catalogue items (`access_state = free`, or `is_free` / zero-price intros) are **not** checkout targets — members use them without a purchase or entitlement row (**DB-4**). The API rejects quote/purchase for those SKUs even if the UI forgot to hide the CTA (**D13**).

### 9.0. Discount resolution (**RF-66**, **RN-26**) — closed

Used identically by `POST /checkout/quote` and `POST /checkout/purchases`. The client may send an optional `promo_code`; it must **never** send the final amount or discount type as authority.

1. Start from the SKU’s **catalogue** `price_cents` (for `bundle_partial`, still the **full** bundle catalogue price — **RN-25** / **RF-65**).
2. Find any **active automatic campaign** that applies to this SKU in the current time window (`discount_campaigns` + link table), **even when no** `promo_code` is present. Take its percent if any.
3. If `promo_code` is present, validate it (active, window, product link, redemptions). Invalid → **422** (quote/purchase fails; do not silently ignore a bad code).
4. **Non-stacking:** code percent and campaign percent **do not add**. Apply the **higher** percentage. On a **tie**, prefer the **code** (`discount_type = code`).
5. If only a campaign applies → `discount_type = auto_campaign`. If neither → `discount_type = none`, `discount_percent = 0`.
6. Compute `amount_paid_cents` from catalogue price and the chosen percent (integer cents; document rounding in implementation if needed).

### 9.1. `POST /checkout/quote`

Preview **without** creating a purchase. **Auth:** required.

**Request:**

```json
{
  "sku": "breed-labrador-bundle",
  "promo_code": "SAVE10"
}
```

`promo_code` optional. Automatic campaigns still apply when omitted (§9.0). No separate validate-only promo route in v1.

**Response 200:**

```json
{
  "sku": "breed-labrador-bundle",
  "type": "bundle",
  "catalogue_price_cents": 1290,
  "discount_percent": 0,
  "discount_type": "none",
  "amount_paid_cents": 1290,
  "currency": "EUR",
  "access_state": "bundle_partial",
  "owned_skus": ["video-a"],
  "missing_skus": ["video-b"],
  "price_note": "Full bundle catalogue price — no reduction for items already owned (RN-25)."
}
```

**Errors (never mix with a 200 “cannot buy” payload):**

| Situation | HTTP | Body |
| --------- | ---- | ---- |
| Already owns SKU / bundle complete | **409** | `error` only (`already_owned` / `bundle_complete`) |
| Free / not purchasable (`access_state = free`, `is_free`, or otherwise available without paying) | **409** | `error` only (`not_purchasable`) |
| Promo invalid, expired, wrong product, exhausted | **422** | `error` only |
| SKU missing | **404** | `error` only |

### 9.2. `POST /checkout/purchases`

**Auth:** required. Creates (or reuses) a purchase.

**Request:** same as quote.  
**Header (recommended):** `Idempotency-Key` (client UUID per purchase attempt). Same key + same user → same response as the first call (persisted in `checkout_idempotency_keys`, TTL ≥ 24 h — **DB-8**).

**Without header:** if a `pending` purchase exists for the same user + same SKU younger than **30 minutes**, reuse it (and its Stripe session if still valid) → **200** with the same `purchase_id` / `checkout_url`, not a second row.

**Behaviour:**

1. Refuse if `access_state` ∈ {`owned`, `bundle_complete`} → **409** (`already_owned` / `bundle_complete`).
2. Refuse if the SKU is free / not purchasable (`access_state = free`, `is_free`, or zero-price intro that needs no payment) → **409** `not_purchasable` (**DB-4**, **D13**).
3. Resolve discount with §9.0 (**RF-66**, **D13**) — ignore client amounts.
4. If `amount_paid_cents = 0` after a **valid paid-path** resolution (e.g. 100% code on a paid SKU): complete purchase + entitlements in one transaction; **no** Stripe; **no** Moloni; **201** with `purchase` + `entitlements_granted` (**RF-67**). This is **not** the free-catalogue path of step 2.
5. If amount &gt; 0: create `pending` purchase + Stripe Checkout Session; **success_url** / **cancel_url** from **server env only** (never from the client body); store `stripe_checkout_session_id` and put `purchase_id` in session metadata; **201** (or **200** if reused) with `checkout_url` + `purchase_id`.

**Poll (**RF-62**):** client keeps `purchase_id` and calls `GET /purchases/{id}`. The Stripe `session_id` in the success URL is navigation only — not the path id.

### 9.3. `GET /purchases/{id}`

**Auth:** required; **own** purchase only (**404** otherwise).

```json
{
  "id": "…",
  "status": "completed",
  "sku": "breed-labrador-bundle",
  "catalogue_price_cents": 1290,
  "discount_type": "none",
  "discount_percent": 0,
  "amount_paid_cents": 1290,
  "currency": "EUR",
  "completed_at": "…",
  "has_invoice": true
}
```

`status`: `pending` \| `completed` \| `failed` (aligned with schema).

---

## 10. Stripe webhook

### 10.1. `POST /webhooks/stripe`

**Auth:** Stripe signature (`Stripe-Signature`). No JWT.

**Events handled in v1** (others → 200 ignored or log only):

| Stripe event | Action |
| ------------ | ------ |
| `checkout.session.completed` | Mark purchase `completed`, grant entitlements, promo redemption if any, idempotent event row; then Moloni if amount &gt; 0 |
| `checkout.session.expired` | If still `pending` → `failed` (or equivalent terminal non-unlock state) |
| `checkout.session.async_payment_failed` | Mark failed if applicable |

**Flow for `checkout.session.completed`:**

1. Verify signature.
2. **Insert-first idempotency:** attempt to insert `event_id` into `stripe_webhook_events` (unique PK). If the insert conflicts (event already seen) → **200** no-op — do **not** rely on a separate check-then-act that races under concurrent Stripe retries (**RF-62**, **RNF-12**, **DB-8**).
3. Resolve purchase: `metadata.purchase_id` if valid UUID, else `stripe_checkout_session_id = session.id`. If none → log + **200** (do not invent a purchase).
4. In a transaction: complete purchase; insert missing entitlements (`purchase` / `bundle`); redemption + increment if code.
5. After commit: try Moloni when `amount_paid_cents > 0`. Failure → log; eligible for internal job §11.3; **do not** reverse entitlements (**RF-63**). On successful paid completion, the API **may** send a purchase confirmation email (**RF-70**) — side effect only.
6. **200** `{ "received": true }`.

---

## 11. Invoices and Moloni job

### 11.1. `GET /me/invoices`

**Auth:** required. **RF-69**. List caller’s invoices: `id`, `purchase_id`, `amount_cents`, `issued_at`, `pdf_url` when present.

### 11.2. `GET /me/invoices/{id}`

Detail for own invoice; **404** otherwise. Client opens `pdf_url` for download/view — API does **not** proxy the PDF in v1.

### 11.3. Internal job — missing Moloni invoice

**Not** a public endpoint. Periodic worker:

- `purchases.status = completed`
- `amount_paid_cents > 0`
- no row in `invoices`

For each: call Moloni sandbox → insert `invoices`. Retries with backoff; access stays if issuance fails (**RF-63**).

---

## 12. Ops (outside the public API)

| Action | How (v1) |
| ------ | -------- |
| Create campaign / promo code | SQL / console ([`sql/09_ops_examples.sql`](sql/09_ops_examples.sql)) — **RF-58**, **RN-26** |
| Manual `grant` entitlement | Ops SQL (`entitlements.origin = grant`) |

No admin CRUD routes in the public API.

---

## 13. Platform helpers

### 13.1. `GET /health`

**Auth:** public. Liveness for Render/ops: `{ "ok": true }` (and optional build/version later).

### 13.2. Cold start (client)

Not an endpoint. If login/auth calls get **no HTTP response within 3 seconds**, the UI shows a wake-up notice and keeps waiting (**D6**). The API contract does not change.

### 13.3. Rate limits

Documented in v1: magic-link **429** (§4.1). Additional limits (checkout, geocode) may be added during implementation if abuse appears — without changing RN/RF.

---

## 14. Out of this document

| Topic | Notes |
| ----- | ----- |
| Institutional landing / blog | Static on Vercel — not this API |
| Weight history persistence | Optional later (**RF-34**, **DB-10**) |
| Sequence / class UML | [`11_UML_DIAGRAMS.md`](11_UML_DIAGRAMS.md) |
| Admin UI for promos | Out of v1 product |

---

## 15. Traceability (summary)

| Concern | Endpoints |
| ------- | --------- |
| RF-11…RF-15, RN-10, D4 | §4 |
| RF-16, D1, D2 | §2.1, §4.2–4.4 |
| RF-19 (welcome email) | §4.2 side effect |
| RF-20, RF-21, D3 (OTC 5 min) | §4.5 |
| RF-23, RF-25 | Auth on members routes; free without entitlement |
| RF-26 (no silent unlock / media gate) | §6.1.1 |
| RF-28…RF-32 | §7 |
| RF-35…RF-42, RF-54 | §6, bundle rules in §9 |
| RF-43…RF-49 | §8 |
| RF-66 / RN-26 (campaign ± code, non-stack, tie → code) | §9.0 (used by §9.1–§9.2) |
| RF-56…RF-68, RNF-12, D10, D13 | §9–§11 |
| RF-70 (purchase confirmation email) | §10.1 side effect |
| RF-69 | §11.1–11.2 |
| Granularity / cold start | §2.0, §5.4, §13.2 |

---

## 16. Status

API contracts for the planned first version are **aligned**: auth, granularity, media gate, discount resolution (**RF-66**), free-SKU checkout refusal, checkout, errors, and webhook idempotency closed (API-1…API-8); living room remains for screen/payload refinement during implementation.
