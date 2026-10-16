# Work Breakdown Structure (WBS) – _The Doghouse_

## 1. Introduction

This document decomposes the work for the first usable version of **The Doghouse** into packages with **estimated solo hours** and **Done when** criteria. It must stay consistent with the [interview annex](INTERVIEW_ANNEX.md), [Scope](01_SCOPE.md), [Personas and flows](02_PERSONAS_AND_FLOWS.md), and [business rules](03_BUSINESS_RULES.md) (`RN-xx`).

It is an **effort forecast** (proposal estimate). It does not replace a fine roadmap when a delivery is opened for implementation. Hours are order-of-magnitude; revisit after the first implemented delivery.

**General note:** Each implementation activity includes self-review against specifications before deployment. Source documentation (comments, technical README) is part of each delivery, not an afterthought.

### 1.1. Conventions

| Item | Value |
| ---- | ----- |
| Unit | **Hours** of effective solo work |
| Granularity | **Medium** — enough to plan; daily tasks live in a delivery roadmap when coding starts |
| Capacity (reference for the schedule) | **2–4 h/day** across up to **7 calendar days/week** when time allows → about **14–28 h/week** (a planning reference, not a commitment to work every day). Real weeks often share the calendar with private client work and smaller freelance jobs, so wall-clock delivery of this public showcase can stretch |
| Leaf hours only | Parent headings are labels; **totals sum leaf packages** |
| Horizon | Usable first version = Deliveries 1–7 (~**420 h** solo): **420÷28≈15 weeks** (~3.5 months) or **420÷21=20 weeks** (~4–5 months). Validation is after that checkpoint. Full package ~591 h — see schedule |
| IDs | **Delivery 1…7** match the Scope delivery sequence |

### 1.2. Out of this WBS

- Continuous social-media / marketing campaigns
- Paid acquisition and partnerships
- Endless editorial video production beyond the launch inventory (**2 free** + **4 paid** workshops); no effort for unpublished “future” workshop videos (no such catalogue SKU in the business rules)
- Live (real-money) Stripe or fiscal Moloni **as operated by this public project** — this repo stays **sandbox** (`RN-19`…`RN-21`); reusers may enable live mode via environment variables

### 1.3. Test and security policy (per delivery)

Aligned to the project’s software process (unit + e2e per delivery; security when the delivery creates or changes an attack surface):

| Type | When mandatory | Frozen tools |
| ---- | -------------- | ------------ |
| **Unit tests** | Critical logic in that delivery | Go `testing`; Flutter `flutter_test`; site JS only if non-trivial logic |
| **E2E** | Critical flows of that delivery | **Playwright**; Stripe **sandbox** + fixtures — **never** live charges |
| **Security pass** | Same Done as unit/e2e **only if** the delivery creates/changes attack surface (auth, session, API, payments, personal data). Not a full-product pentest. If no surface: state **N/A** | Checklist against threats for that surface; tooling chosen at implementation but pass is mandatory |
| **Done** | Delivery *Done when* includes required tests **green** (local CI or simple pipeline when it exists) | |

Roughly **15–25%** of implementation effort sits in automated tests where there is logic.

---

## 2. Summary by phase and delivery

| ID | Package | Hours (est.) | Dependencies |
| -- | ------- | ------------ | ------------ |
| 1 | Planning and specification | **36** | — |
| 2 | Specification, design, and implementation start | **69** | 1 |
| D1 | Delivery 1 – Institutional website | **23** | — (can be first) |
| D2 | Delivery 2 – Backend + authentication | **60** | can run parallel to D1 |
| D3 | Delivery 3 – Free calculator | **30** | D2 |
| D4 | Delivery 4 – Hotels map | **47** | D2; parallel to D3 possible |
| D5 | Delivery 5 – Free workshops | **30** | D2; parallel to D3/D4 possible |
| D6 | Delivery 6 – Payments + premium (sandbox) | **86** | D3+D4+D5 |
| D7 | Delivery 7 – Store publishing | **28** | D6 |
| 3.8 | Cross-cutting code documentation | **11** | continuous with D1–D7 |
| 4 | Testing, validation, deployment hardening | **55** | after core deliveries |
| 5 | Conclusions, report, public article | **30** | after validation |
| | **Subtotal (leaves)** | **~505** | |
| 6.1 | Contingency (~15% of subtotal) | **76** | |
| 6.2 | Unforeseen final adjustments | **10** | |
| | **Grand total** | **~591 h** | |

*Of which automated tests (unit + e2e + per-delivery security passes on D1–D7 leaves) sum to about **~80–90 h**, in line with the **15–25%** of implementation effort note above. A later consolidated security sweep sits in the validation phase (~8 h), after usable v1.*

**Calendar reference** (detail belongs in the schedule document):

| Pace | h/week | Weeks ≈ for **591 h** | Months ≈ |
| ---- | ------ | --------------------- | -------- |
| 2 h/day | 14 | ~42 | ~9–10 |
| 3 h/day | 21 | ~28 | ~6.5 |
| 4 h/day | 28 | ~21 | ~5 |

The Scope/schedule calendar rule: usable **Deliveries 1–7** (~420 h solo) ≈ **15 weeks** at 28 h/week or **20 weeks** at 21 h/week. Parallel bars do not erase solo hours. Quality over a harmful rigid date.

---

## 3. Planning and specification (~36 h)

3.1. Scope definition – **8h**

3.2. User personas and flows (+ use-case diagram) – **10h** (`02`, diagram under `diagrams/`)

3.3. Business rules inventory (`RN-xx`) – **8h** (`03`)

3.4. WBS elaboration – **6h** (this document)

3.5. Initial schedule (Gantt) elaboration – **4h** (`05`)

_Milestone: Initial proposal package ready for review_

**Done when:** Scope, personas/flows, business rules, WBS, and schedule exist and are mutually consistent with the interview annex.

---

## 4. Specification, design, and implementation start (~69 h)

4.1. Research and analysis of similar solutions – **6h**

4.2. Functional and non-functional requirements specification – **12h**

4.3. General architecture design

- 4.3.1. Backend architecture in Go – **3h**
- 4.3.2. Frontend architecture (HTML site + Flutter) – **3h**
- 4.3.3. Containerization strategy with Docker – **2h**
- 4.3.4. Session sharing strategy (**site ↔ Flutter Web** only; `RN-13`) – **2h**

4.4. Database modelling – **10h**

4.5. UML diagrams

- 4.5.1. Class diagram – **4h**
- 4.5.2. Sequence diagrams (critical flows) – **4h**

4.6. API endpoint contracts and interaction flows – **10h**

4.7. Development environment setup

- 4.7.1. GitHub repository setup – **1h**
- 4.7.2. Initial Docker Compose (database, backend, proxy) – **2h**
- 4.7.3. Project folder structure – **1h**

4.8. Base structure implementation start

- 4.8.1. Hello World Go backend – **2h**
- 4.8.2. Institutional website skeleton (HTML/CSS/JS) – **2h**
- 4.8.3. Flutter skeleton (Web, iOS, Android) – **1h**
- 4.8.4. `manifest.json` + service worker for PWA – **1h**

4.9. Use-case diagram maintenance (PlantUML source + render) – **3h**

_Milestone: Architecture and specifications validated_

_Milestone: Interim design package ready_

**Done when:** Research, requirements, architecture, data model, UML, API contracts, and local Docker/Flutter/Go skeletons exist and match `RN-10`…`RN-13` and Scope stack choices.

---

## 5. Complete MVP implementation (Deliveries 1–7)

### 5.1. Delivery 1 – Institutional website (~23 h)

_Dependencies: none (can be first)._  
_Security pass: **N/A** or light static hardening only (no auth/payments)._

- 5.1.1. Landing page HTML structure – **4h**
- 5.1.2. CSS styling and responsiveness – **4h**
- 5.1.3. Static blog content – **3h**
- 5.1.4. SEO (meta tags, JSON-LD, semantics) – **3h**
- 5.1.5. Unit tests (non-trivial JS only; else minimal) – **2h**
- 5.1.6. E2E smoke (Playwright: home, article, key CTAs) – **4h**
- 5.1.7. Deploy on Vercel or Netlify – **2h**
- 5.1.8. Basic security headers / XSS hygiene on static pages – **1h**

_Milestone: Delivery 1 available online_

**Done when:** Landing + blog online; SEO basics in place; Playwright smoke green; no other brands in UI (`RN-03`); English-only product copy (`RN-05`).

### 5.2. Delivery 2 – Base backend with authentication (~60 h)

_Dependencies: can run parallel to Delivery 1; required before D3–D5._  
_Attack surface: auth, session, email, API — **security pass mandatory**._  
_`RN-10`…`RN-13`, `RN-06`._

- 5.2.1. Data model + DB connection (PostgreSQL / Neon path) – **6h**
- 5.2.2. Authentication service (magic link **and/or** Google **and/or** Facebook) – **12h**
- 5.2.3. Transactional email for magic links – **4h**
- 5.2.4. Flutter auth UI (register / sign-in) – **6h**
- 5.2.5. Cookie/token sharing for **site ↔ Flutter Web** – **4h**
- 5.2.6. Seamless redirect with active session (`RN-13`) – **3h**
- 5.2.7. Unit tests (magic link 15 min / single use, JWT 7 days, OAuth stubs) – **6h**
- 5.2.8. E2E (Playwright: magic-link and social happy paths; expired link) – **6h**
- 5.2.9. Security pass (JWT handling, magic-link rate limit, OAuth config, HTTPS, secrets in env) – **4h**
- 5.2.10. Deploy Go API in Docker (Render / Fly.io / Railway) – **3h**
- 5.2.11. Deploy database on persistent free tier (e.g. Neon) – **2h**
- 5.2.12. Deploy Flutter Web shell (login + profile, features later) – **2h**
- 5.2.13. Environment variables + HTTPS verification – **2h**

_Milestone: Delivery 2 online (functional authentication)_

**Done when:** Signed-in free member exists; magic link and social paths work per `RN-10`/`RN-11`; JWT per `RN-12`; seamless site↔Flutter Web for signed-in users only; unit + e2e + security pass green; no email/password (`RN-10`); native apps still authenticate in-app (`RN-13`).

### 5.3. Delivery 3 – Free calculator (~30 h)

_Dependencies: Delivery 2._  
_`RN-08`, `RN-29`._  
_Security: API content endpoints — light pass._

- 5.3.1. Backend content service (breeds + calculator data) – **6h**
- 5.3.2. Free calculator UI in Flutter – **8h**
- 5.3.3. API integration – **4h**
- 5.3.4. Unit tests (breed/age → approximate weight) – **4h**
- 5.3.5. E2E (Playwright: signed-in free calc path) – **4h**
- 5.3.6. Security pass (authz on calculator endpoints) – **2h**
- 5.3.7. Deploy update – **2h**

_Milestone: Delivery 3 online (functional free calculator)_

**Done when:** Signed-in users get approximate ideal weight; paid complete calc remains locked with purchase path visible; tests green.

### 5.4. Delivery 4 – Map with Overpass API and geolocation (~47 h)

_Dependencies: Delivery 2; may run parallel to Delivery 3._  
_`RN-33`…`RN-37`._

- 5.4.1. Overpass module (pet-friendly tags `dog=yes` / `pets=yes`) – **10h**
- 5.4.2. Nominatim geocoding – **3h**
- 5.4.3. Cache with **TTL 24 h** (`RN-36`) – **4h**
- 5.4.4. Flutter map (geolocator with consent, dynamic viewport) – **12h**
- 5.4.5. API integration – **4h**
- 5.4.6. Unit tests (viewport bounds, cache hit/miss) – **5h**
- 5.4.7. E2E (near-me consent decline → text search; marker → open in maps) – **5h**
- 5.4.8. Security pass (input validation on search/viewport; no secret leakage) – **2h**
- 5.4.9. Deploy update – **2h**

_Milestone: Delivery 4 online (functional map)_

**Done when:** Signed-in users search hotels by viewport; geolocation only after consent; cache TTL respected; visitors cannot use the map (`RN-33`); tests green.

### 5.5. Delivery 5 – Free workshops (~30 h)

_Dependencies: Delivery 2; may run parallel to D3/D4._  
_Launch inventory: **2 free introductory** videos by breed (`RN-15`, `RN-31`)._

- 5.5.1. Backend content service (free intros) – **6h**
- 5.5.2. Flutter workshops area (breed list + free playback) – **8h**
- 5.5.3. API integration – **4h**
- 5.5.4. Unit tests (free vs locked listing) – **4h**
- 5.5.5. E2E (watch free intro; paid item locked) – **4h**
- 5.5.6. Security pass (authz on media URLs / content API) – **2h**
- 5.5.7. Deploy update – **2h**

_Milestone: Delivery 5 online (functional free workshops)_

**Done when:** Two free intros play for signed-in users; paid workshops visible but locked; tests green.

### 5.6. Delivery 6 – Payments and premium content (~86 h)

_Dependencies: Deliveries 3, 4, and 5 (matches Scope sequence — map before monetization is a **delivery-order** choice, not a business-rule dependency; payments need calculator/workshop SKUs from D3/D5; D4 is sequenced with them for a complete free surface before premium)._  
_Sandbox only (`RN-19`…`RN-23`); no store IAP (`RN-20`); no refunds (`RN-17`); catalogues independent (`RN-16`); full bundle price on partial upgrade (`RN-25`)._  
_Attack surface: payments — **security pass mandatory**._

- 5.6.1. Stripe Checkout module (**sandbox only**) – **10h**
- 5.6.2. Stripe webhooks (idempotent, retriable) + Flutter polling – **6h**
- 5.6.3. Moloni simulated invoice module (**sandbox**) – **6h**
- 5.6.4. Stripe sandbox account/config – **2h**
- 5.6.5. Moloni sandbox account (logo/template) – **2h**
- 5.6.6. Complete calculator UI (paid SKU, EUR **9.90**) – **6h**
- 5.6.7. Paid workshops + bundles (individual **4.90**, breed **12.90**, complete present **24.90**) – **12h**
- 5.6.8. Conditional access (purchased vs locked; no global premium) – **6h**
- 5.6.9. Anti-repurchase + partial-bundle upgrade at **full** price (`RN-24`, `RN-25`) – **4h**
- 5.6.10. Promotional codes / auto campaigns / **0.00 EUR** path (`RN-26`…`RN-28`) – **6h**
- 5.6.11. Profile + invoice viewing – **4h**
- 5.6.12. Unit tests (webhook idempotency, entitlements, 0 € without Moloni, discount non-stack) – **8h**
- 5.6.13. E2E (sandbox purchase → unlock; declined card stays locked; delayed webhook + poll) – **8h**
- 5.6.14. Security pass (webhook signatures, secret handling, authz on entitlements) – **4h**
- 5.6.15. Deploy update – **2h**

_Milestone: Delivery 6 online (sandbox monetization path)_

**Done when:** Test-card purchase unlocks only bought SKUs; simulated Moloni invoice for amount > 0; failed payment unlocks nothing; same catalogue on Web and native via Stripe (no IAP); unit + e2e + security green.

### 5.7. Delivery 7 – Store publishing (~28 h)

_Dependencies: Delivery 6._  
_`RN-38`. Security: store signing secrets handling — short pass._

- 5.7.1. iOS final config (certificates, profiles, build) – **8h**
- 5.7.2. Android final config (keystore, build) – **4h**
- 5.7.3. App Store submission – **4h**
- 5.7.4. Play Store submission – **4h**
- 5.7.5. Real-device checks after publish – **4h**
- 5.7.6. Security pass (signing material never in public repo; `RN-39`) – **2h**
- 5.7.7. Smoke: native app sign-in + open a free feature – **2h**

_Milestone: Delivery 7 available (store path exercised)_

**Done when:** Store builds submitted or submission path documented as complete; secrets out of Git; native auth in-app works; purchases still Stripe sandbox (no IAP).

### 5.8. Cross-cutting source code documentation (~11 h)

_Continuous across deliveries (counted once)._

- 5.8.1. Comments / docs in Go – **4h**
- 5.8.2. Comments / docs in Flutter – **4h**
- 5.8.3. Technical repository README – **3h**

**Done when:** A new contributor can run local Docker + understand main packages from README and in-code docs.

---

_Milestone: Usable first version online (Deliveries 1–7 Done when — schedule **M9**)_

**Usable first version** means Deliveries **1–7** (and continuous code docs) meet their Done when criteria. It does **not** require the cross-cutting validation phase below.

---

## 6. Testing, validation, and deployment hardening (~55 h)

_Builds on per-delivery tests. This phase is **after** usable v1 (schedule **M10**): beta hardening, not a gate to call Deliveries 1–7 done._

6.1. Functional / non-functional sweeps – **16h**

- 6.1.1. Manual full-flow checks in development – **4h**
- 6.1.2. Usability / UX pass – **3h**
- 6.1.3. Performance (map density, DB, cache hit/miss) – **5h**
- 6.1.4. Cross-platform consistency (Web PWA, iOS, Android) – **4h**

6.2. Final deployment adjustments – **8h**

- 6.2.1. Subdomain layout (site / PWA / API) – **2h**
- 6.2.2. HTTPS verification – **1h**
- 6.2.3. Seamless cookie/token verification (site↔Flutter Web) – **2h**
- 6.2.4. PWA load-time optimization – **3h**

6.3. End-user tests – **6h**

- 6.3.1. Select 3–5 testers – **1h**
- 6.3.2. Collect UX feedback – **3h**
- 6.3.3. Log bugs / suggestions – **2h**

6.4. Final adjustments from feedback – **8h**

- 6.4.1. Bug fixes – **4h**
- 6.4.2. UX polish – **3h**
- 6.4.3. Redeploy – **1h**

6.5. Consolidated security tests – **8h**

- 6.5.1. Input validation / injection (SQL, XSS) – **3h**
- 6.5.2. AuthZ / JWT / magic-link rate limiting – **3h**
- 6.5.3. CORS and security headers – **2h**

6.6. Monitoring and logging – **6h**

- 6.6.1. Sentry (or similar) for error tracking – **2h**
- 6.6.2. Centralized Go logging – **2h**
- 6.6.3. Alerts for critical failures – **2h**

6.7. Rollback / disaster recovery docs – **3h**

- 6.7.1. Backend rollback plan – **1.5h**
- 6.7.2. Flutter / release rollback plan – **1.5h**

_Milestone: Beta hardened (schedule **M10**)_

**Done when:** Critical flows re-checked on Web and stores path; HTTPS and seamless checks pass; consolidated security sweep done; monitoring in place; rollback notes written.

---

## 7. Conclusions and final report (~30 h)

7.1. Final report consolidation – **12h**

- 7.1.1. Executive summary – **2h**
- 7.1.2. Planned vs executed – **3h**
- 7.1.3. Challenges and solutions – **4h**
- 7.1.4. Lessons learned (Docker, Go, Stripe, Moloni, Flutter, PWA, Overpass) – **3h**

7.2. Review and formatting – **6h**

- 7.2.1. Language / style pass on documentation – **3h**
- 7.2.2. Final formatting for delivery – **3h**

7.3. Public article (e.g. engineering narrative outlet) – **8h**

- 7.3.1. Draft on paper-first methodology – **4h**
- 7.3.2. Screenshots and diagrams – **2h**
- 7.3.3. Publication – **2h**

7.4. Technical glossary elaboration – **4h**

_Milestone: Final report and article published_

**Done when:** Report and glossary published in the public docs set; article published or publication path completed.

---

## 8. Contingency and final adjustments (~86 h)

8.1. Contingency buffer (~**15%** of ~505 h subtotal) – **76h**

8.2. Unforeseen final adjustments – **10h**

**Done when:** Buffer is tracked; remaining hours released or consumed with a short note in the schedule / report.

---

## 9. Delivery dependencies

| Delivery | Depends on | Parallelism |
| -------- | ---------- | ----------- |
| **1** Website | — | Can be first |
| **2** Auth | — | Parallel to Delivery 1 |
| **3** Free calculator | **2** | — |
| **4** Hotels map | **2** | Parallel to **3** |
| **5** Free workshops | **2** | Parallel to **3** / **4** |
| **6** Payments + premium | **3** + **4** + **5** | — |
| **7** Stores | **6** | — |

```text
D1 (site) ──┐
            ├── (parallel OK)
D2 (auth) ──┼──► D3 (free calculator) ──┐
            ├──► D4 (map) ─────────────┼──► D6 (sandbox pay + premium) ──► D7 (stores)
            └──► D5 (free workshops) ──┘
```

---

## 10. Conclusion

This WBS estimates about **591 hours** solo (including contingency) for planning, design, Deliveries **1–7**, validation, and closure. Implementation deliveries freeze **sandbox** commerce, passwordless auth, and the launch workshop inventory from the business rules. Per-delivery **unit + e2e** (Playwright / Go `testing` / `flutter_test`) and **security passes** on attack surfaces are part of Done when.

**Next:** the [schedule](05_GANTT.md) maps these packages onto calendar weeks under the shared solo calendar rule (usable v1 ≈ 15 weeks at 28 h/week or 20 weeks at 21 h/week). Prefer quality over a harmful rigid date.
