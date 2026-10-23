# Requirements – functional and non-functional – _The Doghouse_

## 1. Introduction

This document turns the product contract ([`01_SCOPE.md`](01_SCOPE.md), [`02_PERSONAS_AND_FLOWS.md`](02_PERSONAS_AND_FLOWS.md), [`03_BUSINESS_RULES.md`](03_BUSINESS_RULES.md)) and the market lessons ([`06_RESEARCH.md`](06_RESEARCH.md) L1–L13) into **numbered requirements** for the **planned first version** of _The Doghouse_.

It does **not** treat the live institutional site alone as the product goal. Requirements describe the sandbox simulation and reusable skeleton frozen in Scope and business rules: English dog-owner product, passwordless auth, one-time purchases, Stripe/Moloni **sandbox**, hotels map via Overpass, shared Flutter codebase.

Where delivery order differs from a single user journey, the **Delivery** column uses WBS Deliveries **1–7** (see [`04_WBS.md`](04_WBS.md)).

### 1.1. Priority

| Priority | Meaning |
| -------- | ------- |
| **Essential** | Without this, the piece / delivery is not done |
| **Important** | Should land in the same delivery or the next one; defer only with an explicit trade-off |
| **Optional** | Conscious backlog; does not block the delivery Done |

### 1.2. Conventions

| Prefix | Type |
| ------ | ---- |
| **RF-** | Functional requirement |
| **RNF-** | Non-functional requirement |

- Traceability: **RN** → [`03_BUSINESS_RULES.md`](03_BUSINESS_RULES.md); **L** → lesson in [`06_RESEARCH.md`](06_RESEARCH.md) when applicable.
- **Delivery:** **1** Institutional website · **2** Backend + authentication · **3** Free calculator · **4** Hotels map · **5** Free workshops · **6** Payments + premium (sandbox) · **7** Store publishing · **T** transversal / several.
- IDs **RF-01…** and **RNF-01…** are **stable** once published (no renumbering). Reading order by section is not the same as numeric order.
- Product behaviour is **fully decided** here from the freeze. Implementation mechanisms (cookie vs header, concrete Flutter map package wiring) close as architecture decisions in [`08_ARCHITECTURE.md`](08_ARCHITECTURE.md) — not as open product questions in this file.
- When Personas and flows conflict with a business rule, **business rules win**; requirements cite the `RN-xx` that applies.

### 1.3. Personas (summary)

**Visitor** · **Free member** · **Member who paid for something** (per SKU, not a global premium flag) — see [`02_PERSONAS_AND_FLOWS.md`](02_PERSONAS_AND_FLOWS.md). Access ladder: **RN-06**.

---

## 2. Institutional website and blog

| ID | Requirement | Priority | RN | L | Delivery |
| -- | ----------- | -------- | -- | - | -------- |
| RF-01 | Public product name is **The Doghouse**; institutional site (landing) plus path into the members’ area | Essential | RN-01 | — | 1 |
| RF-02 | User-facing language is **English** only; tone friendly and clear for dog owners | Essential | RN-05 | — | 1 / T |
| RF-03 | **No** other brands or professional identities in shipping UI/app chrome or copy | Essential | RN-03 | — | 1 / T |
| RF-04 | Primary audience communicated as **dog owners** (not clinic/shelter/breeder ops) | Essential | RN-04 | — | 1 |
| RF-05 | Landing page presents the product and a clear path to sign in / members’ area | Essential | RN-01, RN-09 | — | 1 |
| RF-06 | Static **blog** articles are readable **without** authentication | Essential | RN-09 | L12 | 1 |
| RF-07 | **No** article comments or embedded social network on the blog in v1 | Essential | RN-40 | L12 | 1 |
| RF-08 | Site is **mobile-first** and readable on small screens (typography, spacing, tap targets) | Essential | — | — | 1 |
| RF-09 | Public site uses **HTTPS** on public endpoints | Essential | RN-43 | — | 1 / T |
| RF-10 | Free host **subdomains** are acceptable at the start if seamless signed-in navigation (**RF-20**) can still be configured | Important | RN-41 | — | 1 / 2 |

*Content placement (breeds, videos, calculator data) is direct via files or database — **no** in-product admin panel (**RF-58**).*

---

## 3. Authentication, session, and profile

| ID | Requirement | Priority | RN | L | Delivery |
| -- | ----------- | -------- | -- | - | -------- |
| RF-11 | Authentication is **magic link** and/or **social login** with **Google** and/or **Facebook** (both providers in scope for v1; mix configurable) | Essential | RN-10 | L11 | 2 |
| RF-12 | Traditional **email-and-password** authentication is **forbidden** in v1 | Essential | RN-10 | — | 2 |
| RF-13 | **Apple Sign-In** is **not** a Doghouse v1 provider (market observation elsewhere does not expand this mix) | Essential | RN-10 | L11 | 2 |
| RF-14 | Magic links are valid **15 minutes**, **single use**; expired or reused → clear message + path to request a new link | Essential | RN-11 | — | 2 |
| RF-15 | System sends the magic-link email when the user requests one | Essential | RN-11 | — | 2 |
| RF-16 | Session uses a **JWT** valid **7 days**, renewable on re-authentication (**RN-12**). Token transport (cookie vs header) is closed in architecture, not left open here | Essential | RN-12 | — | 2 |
| RF-17 | First successful authentication **creates** the user record if needed; later logins **reuse** it | Essential | RN-06 | — | 2 |
| RF-18 | Signed-in user may **view and edit** basic profile (e.g. display name); email changes only as the auth provider allows | Important | — | — | 2 |
| RF-19 | Welcome email after first registration is supported | Important | — | — | 2 |

---

## 4. Seamless navigation and access ladder

| ID | Requirement | Priority | RN | L | Delivery |
| -- | ----------- | -------- | -- | - | -------- |
| RF-20 | **Seamless** navigation: a member already signed in on the **static site** reaches **Flutter Web** without signing in again (shared base-domain cookie or token — mechanism in `08`) | Essential | RN-13 | — | 2 / T |
| RF-21 | From the blog/site, an authenticated member can open the members’ area with the session already active | Essential | RN-13 | — | 2 |
| RF-22 | **Native iOS/Android** authenticate **inside the app**; they do **not** inherit the static-site seamless cookie path | Essential | RN-13 | — | 2 / 7 |
| RF-23 | **Visitors** see landing and blog only; they do **not** use calculator, workshops, hotels map, profile, purchase, or invoices until authenticated | Essential | RN-09 | — | 1 / 2 |
| RF-24 | Access ladder: visitor → free member → member who paid for specific item(s); **no** global “premium everything” flag | Essential | RN-06, RN-07 | L5 | T |
| RF-25 | Free content for **all signed-in** members: basic calculator, **two** free workshop intros, hotels map/list | Essential | RN-08 | L4, L5 | 3 / 4 / 5 |
| RF-26 | Buying one catalogue item never silently unlocks unrelated items; lock/unlock states make ownership obvious | Essential | RN-07, RN-32 | L5 | 5 / 6 |
| RF-27 | Paid items may remain **visible** while locked, with purchase CTA; owned items show unlocked state **without** a buy CTA for that SKU | Essential | RN-24, RN-32 | — | 5 / 6 |

---

## 5. Ideal weight calculator

### 5.1. Free calculator

| ID | Requirement | Priority | RN | L | Delivery |
| -- | ----------- | -------- | -- | - | -------- |
| RF-28 | Free calculator accepts **breed** (from catalogue) and **age** | Essential | RN-29 | L1, L4 | 3 |
| RF-29 | Free calculator returns an **approximate** ideal weight | Essential | RN-29 | L4 | 3 |
| RF-30 | Free version shows a clear path / CTA to purchase the **complete** calculator | Essential | RN-29 | L5 | 3 / 6 |

### 5.2. Complete calculator

| ID | Requirement | Priority | RN | L | Delivery |
| -- | ----------- | -------- | -- | - | -------- |
| RF-31 | Complete calculator is available **only** to who purchased that SKU (lifetime access) | Essential | RN-14, RN-30 | L13 | 6 |
| RF-32 | Complete calculator returns a **richer** result (e.g. percentiles, growth curves, dietary recommendations) | Essential | RN-30 | L6 | 6 |
| RF-33 | Catalogue price for complete calculator is **9.90 EUR** | Essential | RN-18 | — | 6 |
| RF-34 | Saving calculator results for later consultation is **Optional** in v1 (does not change purchase rules) | Optional | RN-30 | — | 6+ |

*Calculator and workshops remain **independent catalogues** (**RF-54**).*

---

## 6. Workshops

| ID | Requirement | Priority | RN | L | Delivery |
| -- | ----------- | -------- | -- | - | -------- |
| RF-35 | Workshops area organised **by breed** | Essential | RN-15, RN-31 | L1, L3 | 5 |
| RF-36 | Launch inventory: **two** free introductory videos and **four** paid videos | Essential | RN-15 | L3 | 5 / 6 |
| RF-37 | Free members watch **free intros only** | Essential | RN-08, RN-31 | L3 | 5 |
| RF-38 | Purchase options: **individual** paid video; **breed bundle**; **complete present** bundle (all paid workshop videos existing at purchase time) | Essential | RN-16 | L2 | 6 |
| RF-39 | **No** catalogue SKU that sells unpublished **future** workshop videos | Essential | RN-16 | L2 | 6 |
| RF-40 | Individual paid video price **4.90 EUR**; breed bundle **12.90 EUR**; complete present **24.90 EUR** | Essential | RN-18 | — | 6 |
| RF-41 | Buyers keep **lifetime** access to purchased workshop entitlements | Essential | RN-14 | L13 | 6 |
| RF-42 | Videos/thumbnails referenced by **URL** (external hosting); v1 does not build a multimedia CDN — implementation detail of content placement, not an access-ladder rule | Important | — | — | 5 / 6 |

---

## 7. Pet-friendly hotels map

| ID | Requirement | Priority | RN | L | Delivery |
| -- | ----------- | -------- | -- | - | -------- |
| RF-43 | Interactive map/list of **pet-friendly hotels** for **all signed-in** members; **no** purchase required; visitors excluded | Essential | RN-33 | L7 | 4 |
| RF-44 | Search: **Near me** (device coordinates via geolocation **after explicit consent**) **or** **text search** via **Nominatim** (or equivalent free geocoding); declining location still allows text search | Essential | RN-34 | L9 | 4 |
| RF-45 | Hotel data from **Overpass API** (_OpenStreetMap_) with pet-friendly tags such as `dog=yes` or `pets=yes` | Essential | RN-35 | L7 | 4 |
| RF-46 | Backend returns hotels inside the current map **viewport** only (no unbounded global dump) | Essential | RN-35 | L7 | 4 |
| RF-47 | Overpass-backed data may be **cached** with **TTL 24 hours**; stale entries refreshed when needed | Essential | RN-36 | — | 4 |
| RF-48 | Marker/detail may show name, address, contact when available | Essential | RN-37 | L9 | 4 |
| RF-49 | **Open in maps** opens the place in the device’s native maps app | Essential | RN-37 | L9 | 4 |
| RF-50 | v1 map scope is **hotels** (not a full POI explorer of parks/vets/etc.) | Essential | RN-33 | L7, L10 | 4 |
| RF-51 | **No** user reviews or hotel booking product in v1 (BringFido-scale features stay out; Scope hotels map is discovery via Overpass, not marketplace) | Essential | — | L10 | 4 |

---

## 8. Payments, invoicing, and entitlements

| ID | Requirement | Priority | RN | L | Delivery |
| -- | ----------- | -------- | -- | - | -------- |
| RF-52 | Model: **one-time purchase** / lifetime entitlement per item or workshop bundle; **no monthly subscription** in v1 | Essential | RN-14 | L2, L13 | 6 |
| RF-53 | Currency **EUR**; catalogue prices as in **RF-33** / **RF-40**; free intros and basic calculator remain **0.00** | Essential | RN-18 | — | 6 |
| RF-54 | Calculator and workshops are **independent catalogues**; cross-catalogue packages out of scope for v1 | Essential | RN-16 | L5 | 6 |
| RF-55 | **No refunds** for calculator or workshop purchases (including after a free intro) | Essential | RN-17 | — | 6 |
| RF-56 | All paid checkouts in this public project run in **Stripe sandbox** (no real-money charges operated here) | Essential | RN-19 | — | 6 |
| RF-57 | Same Stripe catalogue and rules on **Flutter Web** and **native iOS/Android**; **no** Apple/Google **IAP** storefront for these SKUs in v1 | Essential | RN-20 | — | 6 / 7 |
| RF-58 | Content management without in-product **admin panel**; codes/campaigns via script/console against the DB | Essential | RN-06, RN-26 | — | 6 |
| RF-59 | Failed, declined, abandoned, or timed-out payment must **not** unlock content and must **not** create a successful-looking invoice | Essential | RN-22 | — | 6 |
| RF-60 | After Stripe confirms payment: record purchase; unlock **only** purchased entitlement(s); attempt **Moloni sandbox** simulation when paid amount **> 0** | Essential | RN-21, RN-23 | — | 6 |
| RF-61 | Moloni issues a **simulated** PDF (logo, date, amount, purchase data); **no** legal/tax effect in this public project; store invoice reference (and public URL when provided) | Essential | RN-21 | — | 6 |
| RF-62 | Stripe webhooks are **idempotent** and **retriable**; Flutter client may **poll** purchase status so a delayed webhook does not leave a successful payer locked out | Essential | RN-23 | — | 6 |
| RF-63 | If Moloni simulation fails after access is granted, **access stays**; invoice issuance is retried without reversing the purchase | Essential | RN-23 | — | 6 |
| RF-64 | **No re-purchase** of an identical owned SKU: UI hides buy CTA; API rejects checkout | Essential | RN-24 | — | 6 |
| RF-65 | **Bundles / partial ownership:** if user owns every item in a bundle → treat as RF-64; if owns some → bundle CTA at **full** catalogue price; after payment grant only **missing** entitlements; UI explains remaining unlocks | Essential | RN-25 | — | 6 |
| RF-66 | Optional **promotional codes** and **time-bounded automatic campaigns** discount per target SKU; discounts **do not stack** — higher percentage wins; on tie prefer **code**; no affiliate commissions in v1 | Essential | RN-26 | — | 6 |
| RF-67 | Checkout at **0.00 EUR** creates a paid order **without** Stripe session and **without** Moloni invoice; access + commercial snapshot still recorded | Essential | RN-27 | — | 6 |
| RF-68 | Each successful purchase stores a commercial snapshot: catalogue price, discount type (`none` / `code` / `auto_campaign`), percentage, code/campaign reference when any, amount paid | Essential | RN-28 | — | 6 |
| RF-69 | Signed-in buyers can **view/download** simulated invoices for their purchases | Essential | RN-21 | — | 6 |
| RF-70 | Purchase confirmation email after successful paid checkout is supported | Important | — | — | 6 |

---

## 9. Platform, PWA, and stores

| ID | Requirement | Priority | RN | L | Delivery |
| -- | ----------- | -------- | -- | - | -------- |
| RF-71 | One **shared Flutter** product/codebase for Web (**PWA**), iOS, and Android | Essential | RN-38 | — | 2 / 7 |
| RF-72 | App-store **publication path** is in scope for v1 (exercise store submission path) | Essential | RN-38 | — | 7 |
| RF-73 | Repository is **public**; secrets, passwords, keys, and people’s private data stay **out** (env vars / private stores) | Essential | RN-39 | — | T |
| RF-74 | Out of scope for v1 product features: article **comments**; in-product **social** network (likes, followers, profiles); **live support chat**; languages other than English | Essential | RN-40 | L8 | T |
| RF-75 | Advanced visit **analytics** are **not** required in v1 | Important | RN-42 | — | T |

---

## 10. Non-functional requirements

| ID | Requirement | Priority | RN | Delivery |
| -- | ----------- | -------- | -- | -------- |
| RNF-01 | Stack aligned to Scope: site HTML/CSS/JS; members’ area Flutter; API Go; PostgreSQL; Docker where useful | Essential | — | T |
| RNF-02 | **HTTPS** on public endpoints; careful handling of emails and payment-related data (serious minimum) | Essential | RN-43 | T |
| RNF-03 | Responsive UI across mobile, tablet, desktop; primary members’ UX optimised for touch | Essential | — | T |
| RNF-04 | Touch targets adequate for mobile (about **44 pt** minimum height where interactive) | Essential | — | T |
| RNF-05 | Clear visual feedback after actions (success/error); reduced learning curve for first-time dog owners | Essential | RN-05 | T |
| RNF-06 | Common operations (auth request, calculator result, map viewport load, purchase status) remain usable on median mobile networks; map/cache design avoids unbounded Overpass dumps (**RF-46**, **RF-47**) | Essential | RN-35, RN-36 | 4 / T |
| RNF-07 | Secrets (Stripe, OAuth, SMTP, Moloni) never committed; separate environments for local/sandbox | Essential | RN-39 | 2 / 6 |
| RNF-08 | Portability: recent Chrome, Firefox, Safari, Edge for site/Flutter Web; iOS and Android targets for store builds as defined in Delivery 7 | Essential | RN-38 | 7 / T |
| RNF-09 | **Unit tests** on critical logic per delivery that has code: at least auth/session rules, entitlement/unlock rules (incl. no re-purchase / partial bundles), discount resolution when implemented, Stripe webhook handling idempotency, magic-link lifecycle | Essential | RN-11, RN-23…RN-28 | 2+ |
| RNF-10 | **End-to-end tests** on critical flows per delivery: at least magic-link and/or social test path; free calculator; map open when Delivery 4 exists; sandbox purchase happy path + failure leaves content locked | Essential | RN-19, RN-22 | 2+ |
| RNF-11 | When a delivery creates or changes an attack surface (auth, session, API, payments, personal data), the same Done includes a **security pass** on that surface; otherwise **N/A** explicit in the fine roadmap | Essential | RN-43 | 2 / 6 |
| RNF-12 | Checkout resilience: idempotent Stripe webhooks; retriable Moloni simulation; unlock never depends on a single instantaneous webhook delivery (**RF-62**) | Essential | RN-23 | 6 |
| RNF-13 | **API is the authority**: UI may hide CTAs and validate forms for UX; backend re-validates session, SKU, entitlements, discounts, and re-purchase rules (401/403/409/422 as appropriate) | Essential | RN-24, RN-25 | 2 / 6 |
| RNF-14 | Maintainability: layered backend (routes / handlers / services / data); Flutter UI separated from domain/API clients; Git versioning | Important | — | T |
| RNF-15 | **Sandbox / prototype constraints (expected behaviour in this public repo):** Stripe and Moloni run in **test/sandbox** only; simulated invoices have **no** legal value; free-tier hosts may impose **cold starts** and storage limits; availability is demonstrable, not a contractual SLA | Essential | RN-19, RN-21 | T |
| RNF-16 | Free intros and free calculator remain usable without paywall friction beyond **sign-in** | Essential | RN-08 | 3 / 5 |

---

## 11. Traceability matrices

### 11.1. Business rules → requirements

| Area RN | Rules | Main RF / RNF |
| ------- | ----- | ------------- |
| Identity and brand | RN-01…05 | RF-01…RF-04, RF-02, RNF-05 |
| Access and personas | RN-06…09 | RF-23…RF-27, RF-25, RF-58 |
| Authentication and session | RN-10…13 | RF-11…RF-22, RNF-09 |
| Commerce and monetisation | RN-14…28 | RF-52…RF-70, RNF-12, RNF-13, RNF-15 |
| Calculator | RN-29…30 | RF-28…RF-34 |
| Workshops | RN-31…32 | RF-35…RF-41, RF-26 |
| Hotels map | RN-33…37 | RF-43…RF-50, RNF-06 |
| Platform and operations | RN-38…43 | RF-71…RF-75, RNF-01, RNF-02, RNF-07, RNF-08, RNF-11 |

### 11.2. Research lessons → requirements

| Lesson | Main RF |
| ------ | ------- |
| L1 | RF-28, RF-35 |
| L2 | RF-39, RF-52 |
| L3 | RF-35…RF-37 |
| L4 | RF-28…RF-30 |
| L5 | RF-24…RF-27, RF-54 |
| L6 | RF-32 |
| L7 | RF-43…RF-46, RF-50 |
| L8 | RF-74 |
| L9 | RF-44, RF-48, RF-49 |
| L10 | RF-50, RF-51 |
| L11 | RF-11…RF-13 |
| L12 | RF-06, RF-07 |
| L13 | RF-31, RF-41, RF-52 |

### 11.3. Personas / flows → requirements

| Flow ([`02`](02_PERSONAS_AND_FLOWS.md)) | RF |
| ----------------------------------------- | -- |
| Registration / authentication | RF-11…RF-17, RF-14, RF-15 |
| Expired / invalid magic link (§3.9a) | RF-14 |
| Seamless site ↔ Flutter Web | RF-20, RF-21 |
| Native app auth | RF-22 |
| Access free content | RF-23…RF-25, RF-28…RF-30, RF-37, RF-43 |
| Purchase premium / decline / timeout (§3.9b) | RF-56, RF-59, RF-64 |
| Delayed webhook (§3.9c) | RF-62, RF-63 |
| Calculator use | RF-28…RF-34 |
| Workshops use | RF-35…RF-41 |
| Hotels map search | RF-43…RF-49 |
| View invoices | RF-61, RF-69 |

---

## 12. Essential checklist (gate for this design document)

For this requirements document to be considered **closed**, at least these **Essential** items are defined (implementation Done remains per delivery in the WBS):

- [x] Site/blog public surface + English + no foreign brands in UI (**RF-01…RF-07**, **RF-09**)
- [x] Auth mix `RN-10` + magic-link rules + JWT 7 days + seamless Web vs native (**RF-11…RF-16**, **RF-20…RF-22**)
- [x] Access ladder + free entitlements + lock/unlock (**RF-23…RF-27**)
- [x] Free + complete calculator (**RF-28…RF-33**)
- [x] Workshops 2+4, bundles, no future-video SKU, independent catalogues (**RF-35…RF-41**, **RF-54**)
- [x] Hotels map Overpass/viewport/cache/consent (**RF-43…RF-51**)
- [x] Sandbox Stripe/Moloni path, entitlements, discounts, zero-EUR, no IAP (**RF-52…RF-68**)
- [x] Shared Flutter + store path + out-of-scope social (**RF-71…RF-74**)
- [x] Testable RNF: unit, e2e, security-when-surface, checkout resilience, sandbox constraints (**RNF-09…RNF-13**, **RNF-15**)

---

## 13. Conclusion

Requirements cover the **planned first version** of _The Doghouse_ as a public **sandbox simulation**: institutional site and blog, passwordless auth, seamless **site ↔ Flutter Web**, free and paid calculator, breed workshops with one-time bundles, signed-in hotels map, Stripe/Moloni sandbox commerce, and a multiplatform Flutter publication path — without monthly subscription, without Apple auth, without in-product social, and without an admin panel.

IDs **RF-01…RF-75** and **RNF-01…RNF-16** are stable for citation in architecture, database, API, and tests. Older identifiers in as-yet-unrevised design files (`08`–`11`) may still mention legacy `RF##` labels until those documents are rewritten.

**Status:** requirements **aligned** (RF-01…75, RNF-01…16; citation nits closed). Architecture decisions belong in [`08_ARCHITECTURE.md`](08_ARCHITECTURE.md).

**Next (when ordered):** rewrite architecture (`08`), then database / API / UML as needed.
