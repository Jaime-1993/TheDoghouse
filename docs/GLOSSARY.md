# Technical Glossary – _The Doghouse_

## Introduction

Definitions of technical and product terms used in the public documentation of _The Doghouse_. Meanings are scoped to this project (planned first version / sandbox simulation).

Sources of truth for closed decisions: [`08_ARCHITECTURE.md`](08_ARCHITECTURE.md), [`09_DATABASE.md`](09_DATABASE.md), [`10_API_ENDPOINTS.md`](10_API_ENDPOINTS.md), [`11_UML_DIAGRAMS.md`](11_UML_DIAGRAMS.md), and the proposal pack (`00`–`05`, business rules).

This glossary is updated when those documents introduce or rename terms.

## List of Terms

**Access Resolution Logic**  
How the backend decides whether a signed-in member may use a given catalogue item. **Paid** access requires a row in `entitlements` (lifetime, per SKU). **Free** intros and the free calculator do **not** require an entitlement. There is no global “premium everything” flag (**RN-07**, **DB-4**, **D13**, **RNF-13**).

**Access State**  
API field (`access_state`) on catalogue items for the caller: e.g. `none`, `owned`, `bundle_partial`, `bundle_complete`, `free`. Drives buy CTAs and the playback `media_url` gate (**API-4**, **RF-26**, [`10`](10_API_ENDPOINTS.md) §6).

**API** (_Application Programming Interface_)  
Rules and protocols for software-to-software calls. Here, the **Go** REST API on **Render** is the authority between clients (static site, Flutter Web, native apps) and **Neon** PostgreSQL (**D5**, **D13**).

**API Endpoint**  
A specific HTTP route on the API. Contracts live in [`10_API_ENDPOINTS.md`](10_API_ENDPOINTS.md).

**Bearer Token**  
HTTP authentication that sends a token in the `Authorization: Bearer <jwt>` header. Used by **native** iOS/Android clients (**D2**). Web clients use a session **cookie** instead.

**Bundle**  
A sellable workshop package (`contents.type = bundle`) whose children are **videos only** (`bundle_items` — **DB-11**, **RF-54**). Launch options include breed bundles and the **complete present** bundle (**RN-16**). Buyers keep lifetime access to unlocked videos; no monthly subscription in v1.

**Cents (integer money)**  
Monetary amounts stored and exchanged as **integer euro cents** (no floating point in the database or checkout authority). Catalogue and paid amounts use this convention (**DB-1**, **RF-53**).

**Checkout Session**  
A Stripe Checkout Session created by the API for amount &gt; 0. Success/cancel URLs come from **server environment** only. The client polls by **purchase id**, not by treating the Stripe session id as the purchase primary key (**RF-62**, [`10`](10_API_ENDPOINTS.md) §9).

**CI/CD** (_Continuous Integration / Continuous Deployment_)  
Automated build and deploy pipelines. Planned for the Go API, institutional site, and Flutter app from the public GitHub repository.

**Cold Start**  
Delay when a free-tier container wakes after idle. The Go API on **Render** free may cold-start; if login gets no HTTP response within **3 seconds**, the UI shows a wake-up notice and keeps waiting (**D5**, **D6**).

**Complete Present Bundle**  
Workshop SKU that unlocks all **paid** workshop videos existing at purchase time (catalogue price **24.90 EUR** — **RN-16**, **RN-18**, **RF-38**, **RF-40**). Children remain videos only; independent from the calculator catalogue (**RF-54**).

**Containerization**  
Packaging an app and dependencies into containers. The Go API ships as a **Docker** image on Render; Docker Compose supports local development (**D5**, **RNF-01**).

**CORS** (_Cross-Origin Resource Sharing_)  
Browser rules for cross-origin HTTP. The API allowlists **Vercel** origins used by the static site and Flutter Web so cookies can be sent where required (**D2**, **D8**, [`10`](10_API_ENDPOINTS.md) §2.1).

**CRUD** (_Create, Read, Update, Delete_)  
Basic data operations. Catalogue and content placement in v1 are ops/seed — **no** in-product admin CRUD API (**RF-58**).

**Disaster Recovery**  
Backup and restore practices (e.g. Neon point-in-time recovery) and deploy rollbacks if a release fails.

**Discount Campaign**  
Time-bounded automatic percent discount linked to target SKUs in the database. Applied by the API even without a promo code; does **not** stack with a code — higher percent wins; tie prefers the **code** (**RN-26**, **RF-66**, **API-5**). Operated by script/console in v1.

**Docker**  
Container platform used for the Go API image and local Compose setups.

**Entitlement**  
Database row granting a user **lifetime** access to one content SKU (`UNIQUE (user_id, content_id)`). Origins include `purchase`, `bundle`, and `grant`. Free SKUs do not need a row (**DB-4**, **RN-14**).

**Flutter**  
Google’s multiplatform UI toolkit. The members’ area is one Flutter codebase for **Web (PWA)**, **iOS**, and **Android** (**RF-71**).

**Freemium**  
Useful free tier (basic calculator, free intros, hotels map for signed-in members) plus one-time paid SKUs — not a monthly subscription (**RN-08**, **RN-14**).

**Gantt**  
Schedule chart of deliveries and milestones. See [`05_GANTT.md`](05_GANTT.md).

**Geolocator**  
Flutter capability/package for device coordinates after explicit consent (“Near me” on the hotels map — **RF-44**).

**Git / GitHub**  
Version control and the public repository host for this project (**RF-73**).

**Go**  
Language of the REST API backend.

**Hash / SHA-256**  
One-way digest. Magic-link tokens and one-time codes are stored hashed, never plaintext (**09**).

**HTTP / HTTPS**  
Web transfer protocols. Public endpoints use **HTTPS** (**RNF-02**).

**Idempotency**  
Safe retries without duplicate side effects. Checkout may send `Idempotency-Key` (persisted per user); Stripe webhooks insert `event_id` first and no-op on conflict (**DB-8**, **API-7**, **RF-62**, **RNF-12**).

**JSON** (_JavaScript Object Notation_)  
Standard request/response body format for the API. Field names are **English**, aligned with the schema (**10**).

**JSON-LD** (_JSON for Linking Data_)  
Structured data for SEO on the institutional site/blog.

**JWT** (_JSON Web Token_)  
Session token: single JWT, **7 days**, renewed on re-authentication — **no** refresh-token store (**D1**). Web: `HttpOnly` + `Secure` cookie. Native: Bearer header. Never put the JWT in a URL query string (**D2**, **D3**).

**JWT Claim**  
A name/value field inside a JWT (e.g. subject, expiry). Claims stay minimal (**08** §5.2).

**Lifetime access (purchased content)**  
Buyers keep access to the SKUs they unlocked for life in v1 — not a subscription and not a global unlock of unrelated catalogue items (**RN-14**, **RN-07**).

**localStorage**  
Browser persistent storage. **Not** used for the session JWT on Web; session uses an `HttpOnly` cookie (**D2**). May hold non-secret UI preferences only.

**Logging**  
Recording API events for debugging. Avoid secrets in clear text; correlate Stripe by event id (**RNF-12**).

**Magic Link**  
Passwordless email link: **15 minutes**, single use, rate limit **5 / hour / email** (**RN-11**, **RF-14**, **RF-15**). Auth go-live also includes **Google** and **Facebook** OAuth (**D4**) — not magic-link alone.

**Mock**  
Test doubles or simulated providers. Stripe and Moloni run in **sandbox** (simulated money/invoices). Catalogue rows are seeded/ops data, not “fake HTTP” for Overpass (**RN-19**, **RN-21**).

**Moloni**  
Portuguese invoicing product used here in **sandbox**: simulated PDF after paid amount &gt; 0; no legal/tax effect in this public project. Failure must not revoke entitlements (**RN-21**, **RF-63**).

**MVP** (_Minimum Viable Product_)  
In this repo: the planned **first usable version** of the dog-owner product (Deliveries 1–7), also used as a learning and reusable skeleton.

**Neon**  
Hosted PostgreSQL (free tier) chosen for the database (**D9**).

**Nominatim**  
OpenStreetMap geocoding service for text search on the hotels map (**RF-44**).

**OAuth** (_Open Authorization_)  
Third-party login. v1 uses **Google** and **Facebook** (no Apple Sign-In — **RF-13**, **D4**).

**One-time Code (OTC)**  
Short-lived (**5 minutes**), single-use code for seamless **fallback** when a shared Vercel cookie cannot be configured. Exchanged at the API for a session; never a long-lived JWT in the query string (**D3**, **RF-20**, **RF-21**).

**ORM** (_Object-Relational Mapping_)  
Optional pattern to map objects to SQL tables. Implementation may use an ORM, query builder, or SQL — layered Go services remain the architectural requirement (**RNF-14**).

**Overpass API**  
OpenStreetMap query API for pet-friendly hotels in the current map **viewport**, with **24 h** cache (**RF-45…RF-47**).

**Paper-first**  
Documentation and planning guide implementation before code. See [`01_SCOPE.md`](01_SCOPE.md).

**PlantUML**  
Text-to-diagram tool. Sources under `docs/diagrams/plantuml/`; renders under `docs/diagrams/` (context, ER, UML — `08`/`09`/`11`).

**Polling**  
Client repeatedly calls `GET /purchases/{id}` after Stripe Checkout so a delayed webhook does not leave a successful payer locked out (**RF-62**).

**PostgreSQL**  
Relational database engine; hosted on **Neon** in this project.

**Postman**  
HTTP client often used to exercise API endpoints during development.

**Premium**  
Paid catalogue features unlocked per SKU via entitlements — not a global premium role.

**Promo Code**  
Optional percent code linked to target SKUs. Non-stacking rules with campaigns: higher percent wins; tie → code (**RN-26**, **RF-66**). Ops via SQL/console in v1 (**RF-58**).

**Purchase**  
Commerce record for one catalogue SKU checkout (`pending` / `completed` / `failed`), with commercial snapshot (catalogue price, discount type/percent, amount paid). Completing a paid purchase grants missing **entitlements**; 0 EUR paid path skips Stripe/Moloni (**RN-27**, **RN-28**, **09**, **10** §9).

**PWA** (_Progressive Web App_)  
Installable Flutter Web members’ area on **Vercel** (**D8**, **RF-71**).

**Rate Limiting**  
Caps request volume. Magic-link requests: max **5 per hour per email** → **429** (**10** §4.1).

**Render**  
Container host for the Go API (**free** Web Service plan — **D5**). Cold starts accepted (**D6**). Plan B only if free hosting stops serving (**D14**).

**Resend**  
Transactional email provider for magic links and optional welcome / purchase confirmation mail (**D11**, **RF-15**, **RF-19**, **RF-70**).

**REST** (_Representational State Transfer_)  
HTTP API style used by the Go backend (`GET`/`POST`/…, JSON bodies).

**Retry Logic**  
Automatic re-attempts (e.g. Stripe webhook delivery; Moloni simulation job after unlock — **RF-62**, **RF-63**).

**Rollback**  
Reverting a deploy to a previous known-good version.

**Sandbox**  
Test mode for Stripe and Moloni in this public project: no real charges; simulated invoices (**RN-19**, **RN-21**, **D10**).

**Seamless**  
Signed-in navigation from the static site to Flutter Web **without** signing in again. Primary: shared session cookie on **Vercel**. Fallback: OTC (**D3**, **RF-20**, **RF-21**). Native apps authenticate inside the app (**RF-22**).

**Sentry**  
Optional error-tracking product (**D12**). Not required for v1; enable only if chosen. Product analytics stay out (**RN-42**, **RF-75**).

**SEO** (_Search Engine Optimization_)  
Practices for the institutional landing and blog (meta tags, JSON-LD, semantics).

**Service Worker**  
Browser background script used by the PWA for caching/offline behaviours where configured.

**Session Cookie**  
Web session transport: `HttpOnly` + `Secure` (+ `SameSite=Lax` unless a documented exception). Holds the JWT for static site and Flutter Web (**D2**).

**SKU**  
Stable catalogue identifier string (e.g. `calculator-complete`) used in API and commerce; internal rows also have UUIDs (**09**, **10**).

**SMART** (_Specific, Measurable, Achievable, Relevant, Time-bound_)  
Objective style referenced in Scope success criteria.

**SQL** (_Structured Query Language_)  
Language for PostgreSQL. Normative DDL: [`sql/09_schema.sql`](sql/09_schema.sql).

**Stripe**  
Payment provider in **sandbox** for paid checkouts; webhooks are idempotent (**D10**, **RF-56**, **RF-62**). No Apple/Google IAP for these SKUs in v1 (**RN-20**).

**TTL** (_Time To Live_)  
How long cached data stays valid. Overpass-backed hotel data: **24 hours** (**RF-47**, **DB-9**).

**UML** (_Unified Modeling Language_)  
Class and sequence diagrams for implementation support: [`11_UML_DIAGRAMS.md`](11_UML_DIAGRAMS.md).

**Vercel**  
Host for the institutional static site and Flutter Web PWA (same project for seamless cookies — **D8**). Site already live at `https://the-doghouse-iota.vercel.app/`.

**Viewport**  
Visible map bounds. The hotels API returns places inside the current viewport only — no global dump (**RF-46**).

**WBS** (_Work Breakdown Structure_)  
Work packages, hours, and *Done when* criteria: [`04_WBS.md`](04_WBS.md) (proposal order of magnitude **~591 hours** including contingency).

**Webhook**  
Server-to-server HTTP callback. Stripe notifies the API on checkout events; the API verifies the signature and applies insert-first idempotency (**10** §10).

---

_This glossary will be updated whenever new technical terms are introduced in the project documents._
