# Business Rules – _The Doghouse_

## 1. Introduction

This document states the **business rules** that constrain the first version of **The Doghouse**. It is the normative reference for product behaviour. It complements the [interview annex](INTERVIEW_ANNEX.md), the [Scope](01_SCOPE.md), and [Personas and flows](02_PERSONAS_AND_FLOWS.md); it does not replace them. Flows in the Personas document illustrate these rules; when wording differs, **this document wins** for product obligations.

Each rule has a stable identifier (`RN-xx`) so later requirements, modelling, and tests can cite it. Rules are written for the **MVP** as frozen here: English product, sandbox commerce, and no in-product administration panel. The simulated product owner still answers that they want to **sell** and **make money** (interview annex **H**, **I**, Q15). This **public** project implements that brief as a **sandbox simulation** (Stripe/Moloni test mode). Someone who reuses the skeleton may switch to live providers with their own secrets and environment variables.

## 2. Identity and brand

**RN-01.** The public product name is **The Doghouse**. There is an institutional website and a members’ area with tools for dog owners.

**RN-02.** On the product surface, The Doghouse is shaped like a **real product and business** for dog owners. This public repository is a **simulation and reusable skeleton** (no external paying client). The developer owns the repository and decides technical and learning boundaries in the Scope.

**RN-03.** **No other brands or professional identities** appear in the shipping Doghouse **user interface** or **application experience** (site, members’ area, store builds). Documentation may name other brands (for example Doses Pediátricas or The Pharmacist, but tech) only to explain why this public repository exists. Those names must not leak into production UI copy or chrome.

**RN-04.** Primary audience: **dog owners**. The product is **not** operations software for clinics, shelters, or breeders.

**RN-05.** User-facing language is **English** only in the first version. Tone is friendly and clear — like someone who likes animals, without unnecessary jargon.

## 3. Access levels and personas

**RN-06.** Access ladder: **visitor** (site and articles) → **free member** (signed in, no purchases) → **member who paid for something** (access only to purchased items). There is **no** in-product admin panel in v1; content is placed directly through files or the database.

**RN-07.** There is **no global “premium everything” status**. A paying member unlocks **only** what they purchased. Buying the complete calculator does not unlock paid workshops; buying a workshop or workshop bundle does not unlock the calculator or unrelated workshops.

**RN-08.** Free content for all **signed-in** members includes: the **basic calculator**, the **two free introductory workshop videos** at launch (organised by breed), and the **hotels map/list**. Paid items may stay visible but locked until purchased.

**RN-09.** Visitors see landing page and blog only. They do **not** use calculator, workshops, hotels map, profile, purchase, or invoices until authenticated.

## 4. Authentication and session

**RN-10.** Authentication is **magic link** and/or **social login** (**Google** and/or **Facebook**). Exact provider mix may be configured, but both Google and Facebook are in scope for v1. Traditional **email-and-password** authentication is **forbidden** in the first version.

**RN-11.** Magic links are valid for **fifteen minutes** and are **single use**. After expiry or consumption, the user must request a new link. The product shows a clear message and a path to request again.

**RN-12.** User session uses a **JWT** valid for **seven days**, renewable on re-authentication.

**RN-13.** **Seamless** navigation without repeating login applies to **signed-in** members moving between the **static institutional site** and **Flutter Web** (shared base-domain cookie or token). Visitors who are not signed in must authenticate. **Native iOS and Android** apps authenticate **inside the app**; they do not inherit the static-site seamless cookie path.

## 5. Catalogue, commerce, and monetisation

### 5.1. Selling model

**RN-14.** The business **sells** premium content: the complete calculator, individual paid workshop videos, and workshop **bundles**. Buyers keep **lifetime** access to what they paid for. There is **no monthly subscription** in the first version.

**RN-15.** Workshop launch inventory: **two** free introductory videos and **four** paid videos, **organised by breed**.

**RN-16.** Workshop purchase options are:

- an **individual** paid video;
- a **breed bundle** (paid videos for that breed as designed);
- a **complete present** bundle (all **paid** workshop videos existing at purchase time).

There is **no** catalogue SKU that sells unpublished **future** workshop videos. Buyers keep **lifetime access** to what they purchased (**RN-14**). Post-launch editorial production is outside the proposal effort estimate.

Calculator and workshops are **independent catalogues**. Cross-catalogue packages (calculator plus workshops in one SKU) are **out of scope** for v1 unless explicitly added later as a named exception.

**RN-17.** **No refunds** for calculator or workshop purchases (including after watching a free intro and then buying).

**RN-18.** **Currency** for catalogue prices is **EUR**. Catalogue prices for v1 are:

| SKU | Price (EUR) |
| --- | ----------- |
| Complete calculator | **9.90** |
| Individual paid workshop video | **4.90** |
| Breed bundle | **12.90** |
| Complete present workshop bundle | **24.90** |

Free intros and the basic calculator remain **0.00** (no charge). These figures are **product catalogue** prices for the sandbox simulation, not an author hourly rate or service fee.

### 5.2. Sandbox payments and invoicing

**RN-19.** In this public project, **all** paid checkouts run in **Stripe sandbox** (test mode). There are **no real-money charges** operated here. The product demonstrates the sell-and-unlock path with test cards and sandbox webhooks. Reusers may point environment variables at live Stripe if they choose.

**RN-20.** Checkout uses **Stripe** with the **same catalogue and rules** on **Flutter Web** and on **native iOS/Android**. There is **no** Apple or Google **in-app purchase** storefront for these SKUs in v1.

**RN-21.** Receipt/invoice is **in for v1** via **Moloni** in **sandbox**. Moloni issues a **simulated** PDF (logo, date, amount, purchase data). Simulated invoices have **no legal value** and no tax-authority effects in this public project. The backend stores the invoice reference (and public URL when provided) against user and purchase. Reusers may configure live Moloni with their own secrets if they choose.

**RN-22.** A **failed**, declined, abandoned, or timed-out payment must **not** unlock content and must **not** create a successful-looking invoice.

**RN-23.** After Stripe confirms payment in sandbox, the backend records the purchase, unlocks **only** the purchased entitlement(s) for **lifetime** access, and attempts Moloni simulation when the paid amount is greater than zero. Stripe webhooks are treated as **idempotent** and **retriable**. The Flutter client may **poll** purchase status so a delayed webhook does not leave a successful payer locked out. If Moloni simulation fails after access is granted, access **stays**; invoice issuance is retried without reversing the purchase.

### 5.3. Re-purchase, upgrades, and zero-amount edge cases

**RN-24.** **No re-purchase** of an identical owned SKU: if the user already has lifetime access to that SKU, the UI does **not** show a purchase CTA and the API **rejects** a new checkout for it.

**RN-25.** **Bundles and partial ownership:** if the user already owns **every** item covered by a bundle, treat as **RN-24**. If they own **some** but not all (for example an individual video, then the breed bundle), the bundle CTA remains at the **full catalogue price** of the bundle (no automatic price reduction for items already owned). After payment, the system grants only **missing** entitlements and does not duplicate access records needlessly. The UI should indicate that the purchase unlocks the remaining items.

**RN-26.** Optional **promotional codes** and **time-bounded automatic campaigns** may discount a checkout **per target SKU** (single video, calculator, or bundle SKU). Discounts **do not stack**: if both a valid code and a valid campaign apply to the same SKU, apply the **higher percentage**; on a tie, prefer the **code**. Codes and campaigns are operated by script or console against the database in v1 (no admin panel). Affiliate commissions are out of scope.

**RN-27.** A checkout that resolves to **0.00 EUR** (for example a 100% code on a paid SKU, or a free catalogue item) creates a paid order **without** a Stripe session and **without** a Moloni invoice. Access and a commercial snapshot are still recorded.

**RN-28.** Each successful purchase stores a simple commercial snapshot: catalogue price, discount type (`none` / `code` / `auto_campaign`), percentage applied, code or campaign reference when any, and amount paid.

## 6. Calculator

**RN-29.** The **free** calculator accepts breed and age and returns an **approximate** ideal weight, with a clear path to purchase the complete version.

**RN-30.** The **complete** calculator is available only to who purchased that SKU. It returns a richer result (for example percentiles, growth curves, and dietary recommendations). Saving results for later is **optional later** and does not change purchase rules.

## 7. Workshops

**RN-31.** Workshops are organised **by breed**. Free users watch free intros only. Paying users watch free intros plus purchased videos or videos covered by purchased bundles, according to **RN-16** and **RN-07**.

**RN-32.** Lock and unlock states must make ownership obvious. Unlocking one item never silently unlocks unrelated catalogue items.

## 8. Hotels map

**RN-33.** The pet-friendly hotels map is available to **all signed-in** members (free and premium). It does **not** require a purchase. Visitors do not use the map.

**RN-34.** Search starts with **Near me** (device coordinates via the `geolocator` package **after explicit consent**) or **text search** resolved with **Nominatim** (or the same free geocoding approach). Declining geolocation still allows text search.

**RN-35.** Hotel data comes from the **Overpass API** (_OpenStreetMap_) using pet-friendly tags such as `dog=yes` or `pets=yes`. The backend returns hotels inside the current map **viewport** (north, south, east, west). There is no single unbounded dump of the global catalogue.

**RN-36.** Overpass-backed hotel data may be **cached** with a **TTL of twenty-four hours**. Stale cache entries are refreshed from Overpass when needed.

**RN-37.** Marker details may show name, address, and contact when available, plus **Open in maps** to the device’s native maps app.

## 9. Platform and operations

**RN-38.** One **shared Flutter product** and codebase for Web (_PWA_), iOS, and Android. App-store publication path is in scope for v1.

**RN-39.** The project repository is **public**. Secrets, passwords, keys, and people’s private data stay **out** of it (environment variables and private stores).

**RN-40.** Out of scope for v1 product features: article **comments**; in-product **social** network features (likes, followers, profiles); **live support chat**; languages other than English in the product.

**RN-41.** No expensive **custom domain** is required at the start. Free host subdomains are acceptable if seamless signed-in navigation (**RN-13**) can still be configured carefully.

**RN-42.** Advanced visit analytics are **not** required in v1. Contacts are answered when the operator can.

**RN-43.** From day one the product uses **HTTPS** on public endpoints and careful handling of emails and payment-related data (serious minimum; deeper security design follows in later documents).

## 10. Summary by area

| Area | Rules |
| ---- | ----- |
| Identity and brand | RN-01 … RN-05 |
| Access and personas | RN-06 … RN-09 |
| Authentication and session | RN-10 … RN-13 |
| Commerce and monetisation | RN-14 … RN-28 |
| Calculator | RN-29 … RN-30 |
| Workshops | RN-31 … RN-32 |
| Hotels map | RN-33 … RN-37 |
| Platform and operations | RN-38 … RN-43 |

## 11. Conclusion

These rules freeze how The Doghouse behaves for the first version: English dog-owner product, passwordless access, per-item lifetime purchases in **Stripe sandbox**, **simulated Moloni** invoices, independent calculator and workshop catalogues with explicit bundles, and a signed-in hotels map driven by Overpass viewports. The public repository is a sandbox simulation and reusable skeleton. They give a stable base for work breakdown, schedule, requirements, and implementation without an in-product admin persona and without mixing other brands into the shipping experience.

When Personas and flows describe a journey, implementers should satisfy the matching `RN-xx` identifiers above.
