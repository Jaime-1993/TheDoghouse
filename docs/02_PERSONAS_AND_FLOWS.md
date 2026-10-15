# User Personas and Flows – _The Doghouse_

## 1. Introduction

This document identifies and characterises the user personas that interact with **The Doghouse**, and describes the main usage flows those personas follow on the institutional website and in the members’ area. It guides later work on requirements, data modelling, and _API_ endpoint design.

Persona definitions make needs, goals, and constraints explicit for each access level. Flows describe, step by step, how people and the system interact. Together they support architecture validation and feature prioritisation for the _MVP_.

The document is grounded in the [interview annex](INTERVIEW_ANNEX.md) and must stay consistent with the [Scope](01_SCOPE.md). **The Doghouse** is a real product for dog owners. There is no in-product administrator persona in the first version: content is placed directly through files or the database. Clinics, shelters, and breeders running their **operations** are out of audience scope.

Rules that constrain these flows are summarised in §5 and detailed in [03_BUSINESS_RULES.md](03_BUSINESS_RULES.md).

**Diagrams:** PlantUML sources live under [`diagrams/plantuml/`](diagrams/plantuml/); rendered images live under [`diagrams/`](diagrams/). This document embeds the use-case diagram in the annex. Class and sequence diagrams belong in the UML document.

## 2. User Personas

The Doghouse has three personas, defined by access level and purchase history. There is no administrator profile in the _MVP_.

### 2.1. Visitor

The visitor uses the institutional website **without** a registered or authenticated account.

**Human context:** someone who found The Doghouse through search or a shared link, wants a clear sense of the project, and may read an article about dog care before deciding whether to create an account. They should not hit friction or opaque jargon on first contact.

- **Goals:** learn what The Doghouse is; read blog articles; decide whether to register for the members’ area.
- **Needs:** a clear value proposition, friendly English copy, and a short path into registration or sign-in.
- **Access:** landing page and blog only. No members’ area features (calculator, workshops, hotels map, profile, purchases, or invoices) until they authenticate. The blog is open without authentication to support _SEO_ and organic traffic.

### 2.2. Free User

The free user has completed registration and authentication via **magic link** and/or **social login** (_Google_ and/or _Facebook_), but has **not** yet purchased any premium content.

**Human context:** a dog owner who already trusts the site enough to create an account — they try the free calculator, watch introductory workshop videos, and browse pet-friendly hotels, while deciding whether a paid calculator result or a paid video is worth buying.

- **Goals:** use free features; understand what premium content unlocks; feel confident before paying.
- **Needs:** simple onboarding without a traditional password; locked premium items that stay visible with a clear purchase path; no confusion about what is free versus paid.
- **Access:** free (basic) calculator; **two** free introductory workshop videos at launch (organised by breed); hotels map/list with no free/premium radius split; profile; ability to start a purchase. Paid calculator and paid workshops remain visible but locked.

### 2.3. Premium User

“Premium” means the member has purchased **one or more** premium items. Access is **only** to what they bought — there is no global premium unlock and no monthly subscription in the first version.

**Human context:** the owner who paid for the complete calculator for richer guidance, or for a specific workshop video or _bundle_, and expects lifetime access to those items plus a clear view of what they still do not own.

- **Goals:** use purchased content; keep lifetime access to those items; buy more later; view receipts/invoices for purchases.
- **Needs:** a transparent portfolio (“I have this / I do not have that”); reliable unlock after payment; consultable invoicing even in _Moloni_ sandbox (simulated documents).
- **Access rules (critical):**
  - Buying the **complete calculator** does **not** unlock paid workshops.
  - Buying a **workshop video** or **bundle** does **not** unlock the complete calculator or unrelated workshops.
  - Access is **lifetime** for each purchased item; unpurchased items stay locked.
  - Hotels map remains available to all signed-in members (free and premium) without purchase.

## 3. Usage Flows

The flows below are the main user journeys, from first contact through concrete tasks in the members’ area.

### 3.1. Registration and Authentication

This flow describes how a visitor becomes a free user.

The visitor opens the landing page and chooses **Member Area** or **Register**. The system offers:

1. **Magic link** — the user enters an email address; the system sends a single-use magic link valid for **fifteen minutes**; the user clicks the link and is authenticated.
2. **Social login** — the user chooses **Google** and/or **Facebook** (exact provider mix as configured; both are in scope for the first version); the system redirects to the provider; after authorisation, the system receives the return and authenticates the user.

After success, the user lands in the _Flutter_ members’ area with an active session and is a **Free User**. Traditional email-and-password authentication is **not** supported.

### 3.2. Seamless Navigation Between Website and Flutter Web

This flow covers the continuous transition between the institutional site (_HTML_, _CSS_, _JavaScript_) and the **Flutter Web** members’ area (_PWA_), without repeating login.

It applies only to **already signed-in** free or premium members. Visitors who are not signed in must still authenticate.

The signed-in member browses the blog (or another public page) and clicks a control such as **Try this in the app** or **Open members’ area**. The site redirects to the Flutter Web subdomain. The application reads the shared cookie or authentication token configured for the shared base domain, recognises the active session, and opens the members’ area without asking for credentials again.

**Native _iOS_ and _Android_ apps** use the Flutter members’ area on their own. Seamless cookie/token sharing documented here is **site ↔ Flutter Web**, not automatic SSO from the static site into the store apps. Store apps obtain a session through the same magic-link or social login flows inside the app.

### 3.3. Access to Free Content

The free user opens the Flutter members’ area and uses the three domains as follows.

- **Calculator (free):** select breed and age; the system returns an approximate ideal weight (basic version) and prompts to unlock the complete version.
- **Workshops (free):** at launch, **two** free **introductory** videos, organised by breed; the user can watch those intros only.
- **Hotels:** interactive map/list of pet-friendly hotels for all signed-in members. There is no free-versus-premium map tier.

Paid content (complete calculator, paid workshops and bundles) remains visible but locked, with a clear premium indication and a purchase control.

### 3.4. Purchase of Premium Content

#### 3.4a. Purchase initiation

The free (or already paying) user tries locked content — complete calculator, a paid workshop video, or a workshop _bundle_. The system shows that the item is premium, the catalogue price (EUR amounts frozen in the business rules), and **Buy**. On confirm, the backend creates a _Stripe_ Checkout session in **sandbox** only (no real-money charges in the first version) and redirects the user to Stripe. The user pays with **test cards** and confirms.

Purchase options for workshops include:

- an **individual** paid video;
- a **breed bundle** (all paid videos for that breed as designed);
- a **complete present** bundle (all workshop videos existing at purchase time);
- a **lifetime** bundle (present and future workshop videos as designed).

Each option has its own price and grants the matching access. There is no monthly subscription.

If the user already owns an individual video of a breed and later buys the **breed bundle**, the bundle purchase grants the remaining access for that breed. In this version the product charges the **full bundle price** (it does not compute a price difference for prior purchases). Access is not duplicated; the user simply holds the broader entitlement.

#### 3.4b. Webhook processing, unlocking, and invoice

Stripe processes the payment and sends a webhook to the _Go_ backend. The backend validates the webhook, records the purchase (user ↔ acquired content), and stores purchase timing for invoicing.

The backend then calls **Moloni** in a **sandbox** environment to generate a **simulated** invoice _PDF_ (project logo, date, amount, purchase data). The document demonstrates the invoicing flow; it has **no legal value** and no tax-authority effects in this mode. The backend stores the invoice reference (and public URL when provided) against the user and purchase.

The Flutter client detects unlock via polling or equivalent status check. Content unlocks for **lifetime** access to the purchased item(s) only. Stripe webhook retries and client polling cover delayed confirmation so a successful payer is not left locked out indefinitely.

### 3.5. Using the Calculator

- **Free:** breed + age → approximate ideal weight message; prompt to purchase the complete version for percentiles, growth curves, and dietary recommendations.
- **Complete (paid):** the purchaser selects breed and age and receives the richer result set above. Saving results for later reference is **optional later** and does not change purchase rules.

### 3.6. Using the Workshops

Workshops are organised **by breed**. Launch inventory: **two** free introductory videos and **four** paid videos.

- Free users watch free intros only.
- A purchaser of an individual video watches that video (plus free intros).
- A breed-bundle purchaser watches all videos of that breed covered by the bundle.
- A complete-present purchaser watches all workshop videos existing at purchase time.
- A lifetime-bundle purchaser watches present and future workshop videos as designed.

Lock and unlock states must make ownership obvious. Buying one item never silently unlocks unrelated catalogue items.

### 3.7. Searching for Hotels on the Map

Available to **all signed-in** members (free and premium). Visitors do not use the map.

The user opens the map area and starts a search in one of two ways:

1. **Near me** — after explicit consent, the app obtains device coordinates through the `geolocator` package and centres the map.
2. **Text search** — the user types a place (for example “Porto”); the system uses **Nominatim** (or the same free geocoding approach) to resolve coordinates and centre the map. Declining geolocation still allows text search.

In both cases the frontend sends the current map **viewport** (north, south, east, west). The backend queries the cache or the **Overpass API** for pet-friendly hotels using tags such as `dog=yes` or `pets=yes` within those bounds, and returns only hotels visible in that area. Panning or zooming repeats the request with the new viewport. There is no fixed global radius dump of the whole catalogue in one call.

Selecting a marker shows available details (name, address, contact when present) and an **Open in maps** action that opens the device’s native maps app.

### 3.8. Viewing Invoices

After a successful purchase, the premium user opens **My invoices** (or equivalent) in the members’ area, sees invoices tied to their purchases, and opens or downloads the _PDF_ via the stored Moloni public URL when available. Moloni sandbox customisation (logo/template) is enough to demonstrate visual identity; documents remain simulated until a later production step.

### 3.9. Error-handling flows

#### 3.9a. Expired or invalid magic link

If the user clicks a link after the **fifteen-minute** window, or reuses a consumed single-use token, the system shows a clear message and offers a control to request a new magic link (email preferably pre-filled).

#### 3.9b. Payment declined or timeout

Stripe surfaces the failure on its payment page. The backend receives no success webhook, so content stays locked and no successful-looking invoice is created. The user may retry.

#### 3.9c. Delayed or failed Stripe webhook after successful payment

Stripe may retry the webhook. Meanwhile the Flutter app polls purchase status. Once the backend records the purchase, content unlocks. Unlock must not depend on a single instantaneous webhook delivery.

### 3.10. Time constants

These constants are fixed for the proposal package and must be reflected in modelling and backend logic:

| Constant | Value |
| -------- | ----- |
| Magic link | **15 minutes** validity; **single use** |
| Overpass / hotel data cache | **TTL 24 hours** |
| User session (_JWT_) | **7 days**; renewable on re-authentication |

## 4. Persona to Feature Mapping

The **visitor** reaches the landing page, the blog, and the start of registration or authentication — nothing inside the members’ area until signed in.

The **free user** uses the basic calculator, the two free introductory workshop videos, the full hotels map for signed-in members, and their profile; they can start purchases. After a first successful purchase they can view invoices for what they bought and become a premium user for those items.

The **premium user** keeps everything a free user can do, plus lifetime access to each purchased item (complete calculator and/or workshop videos/_bundles_ as bought), and invoice viewing for those purchases. The map never requires a purchase. Ownership stays per item: calculator purchase does not open paid workshops, and the reverse does not open the calculator.

## 5. Rules That Constrain These Flows

The following rules condition the flows above. Normative detail lives in [03_BUSINESS_RULES.md](03_BUSINESS_RULES.md); this section is the bridge for readers of personas and flows.

1. Authentication is **magic link** and/or social login (**Google** and/or **Facebook**) only — no email-and-password in the first version.
2. Purchases are **individual** (or explicit _bundles_); access is **lifetime**; no monthly subscription in v1; **no refunds**.
3. Access is **conditional per content** — no global premium status.
4. Free content for signed-in members: basic calculator, two free intros at launch, hotels map.
5. Magic link: **15 minutes**, single use.
6. Overpass-backed hotel data may be cached with **TTL 24 hours**.
7. Geolocation only after consent; text search remains available if declined.
8. _Stripe_ checkouts in v1 are **sandbox only** (no real-money charges). Moloni invoices run in **sandbox** as **simulated** documents (no legal/tax effect until a later production step).
9. Map queries respect the current **viewport**.
10. Seamless session sharing is **signed-in site ↔ Flutter Web**; native store apps authenticate inside the app (same Stripe catalogue; no store IAP in v1).
11. Breed-bundle upgrade after owning an individual video charges the **full bundle price** and grants the broader entitlement without duplicating access records needlessly.

## 6. Conclusion

Personas and flows for The Doghouse follow **visitor → free user → premium user (per purchase)**. The product model is flexible purchase rather than a global subscription: people buy the calculator, individual videos, or workshop bundles, and keep what they paid for.

Modern authentication (magic link and/or Google and/or Facebook), seamless navigation between the static site and Flutter Web for signed-in members, viewport-based hotel search via Overpass, and sandbox Stripe/Moloni paths give a concrete basis for requirements, modelling, _API_ design, and UML work — without inventing an in-product admin persona in the first version.

---

## Annex – Use Case Diagram

**PlantUML source:** [`diagrams/plantuml/usecase_diagram.puml`](diagrams/plantuml/usecase_diagram.puml)  
**Rendered image:** [`diagrams/usecase_diagram.png`](diagrams/usecase_diagram.png)

![Use Case Diagram](diagrams/usecase_diagram.png)

_Figure 1 – Use Case Diagram of The Doghouse. Actors: Visitor, Free User, and Premium User (generalisation chain). Main use cases: landing and blog access, registration, authentication, seamless transition between the static site and Flutter Web, free and premium content (including bundles), hotel search, purchase, invoice viewing, and profile management. «extend» from premium content to free content access means paid access optionally enriches the free content use case. View Invoices is associated with Premium User after purchase; it does not «include» Purchase Content._
