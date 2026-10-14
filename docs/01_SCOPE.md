# Scope Definition – _The Doghouse_

## 1. Introduction

This document defines the scope of the Minimum Viable Product (_MVP_ — the smallest useful first version) of **The Doghouse**: a **real product and business** for dog owners. It combines an institutional website (landing page and articles) with a members’ area that offers a weight calculator, video workshops, and a map/list of pet-friendly hotels — so people can discover the project, use free tools, and buy paid workshops and extras.

The author of this public repository is the same person who decides product scope. There is **no external paying client**. Learning and portfolio practice for engineering are welcome in this repository and are stated **alongside** the product boundaries below — they do not replace the product goal, and they do not introduce other brands or professional identities into The Doghouse (see the [interview annex](INTERVIEW_ANNEX.md)).

Product decisions for the proposal are frozen in the interview annex (table of decisions **A–K** and the answers that support them). This Scope must stay consistent with those decisions. How the system is built in detail is decided in later design documents (research, requirements, architecture, and so on).

The project is conducted using a _paper-first_ methodology: documentation and planning guide implementation so that product and technical choices are conscious before code is written.

## 2. Motivation

1. **Product for dog owners.** Tips and tools are scattered across social media. The Doghouse is a stable place with a clear site, useful members’ tools, workshops that can be sold, and pet-friendly hotels that help attract people.
2. **One author, one public product.** Scope changes are decided by the repository author. Public site, app, and documentation stay under the **The Doghouse** name only — no other brands mixed in.
3. **Learning in the open.** The same public repository supports deliberate practice with a modern stack (for example _Go_, _Flutter_, _Docker_, payments, and maps). Those aims sit next to the product scope; they do not turn the _MVP_ into an abstract exercise or a skeleton “for another client”.

## 3. Objectives

The _MVP_ objectives follow _SMART_ criteria and the frozen interview decisions:

- **Specific:** Ship a usable first version: institutional site + articles; members’ area on phone, computer browser, and installable web app (same shared product/codebase); free and paid calculator; workshops at launch (**2 free** and **4 paid**), organised by breed; pet-friendly hotels map/list; simple sign-in; selling with receipt/invoice in v1 (trial/test mode first if safer); app-store publication path.
- **Measurable:** Done when a dog owner can find the site, create an account without undue friction, use free content, buy a workshop, keep access to what they paid for, use the hotels map usefully, and — if already signed in — move from the site to the members’ area without signing in again. Flows work on phone and computer.
- **Achievable:** Prefer free or cheap plans at the start; no expensive custom domain required for v1. Quality beats a rigid date that hurts the product.
- **Relevant:** Success is a product people can use and buy from, with careful handling of personal and payment data — not a pretty shell that cannot sell or help.
- **Time-bound:** Horizon on the order of **two to three months** of work for something usable; milestones are set as work proceeds.

## 4. Proposed Solution

### 4.1. Institutional Website (_Landing Page_ + Articles)

Developed in pure _HTML_, _CSS_, and _JavaScript_, without heavy _frameworks_, to favour _SEO_ and fast loading. The landing page presents The Doghouse and a clear path to the members’ area. Articles are readable without an account and help attract visitors. No article comments in the first version.

### 4.2. Members’ Area (_Flutter_ — _Web_ / _PWA_, _iOS_, _Android_)

One shared product and codebase across phone, computer browser, and installable web app (add to home screen), also published toward the main app stores. Three functional areas:

- **Ideal weight calculator:** useful free version; full paid version for who paid.
- **Workshops:** video library organised by breed. At launch: **2 free** and **4 paid** videos. Buyers keep access to what they paid for (no monthly subscription in v1).
- **Pet-friendly hotels:** map/list (for example via the _Overpass API_), ideally near the user or a searched city, with a way to open a place in the device’s maps app.

### 4.3. _Backend_ in _Go_ with _REST API_

A _REST_ (_Representational State Transfer_) _API_ in _Go_ supports accounts and sessions, content access, payments, invoicing (trial/test mode acceptable for v1), hotel search integration, and email for sign-in flows as designed. There is **no in-product admin panel** in v1 — content is placed directly (files or database).

## 5. Functional Scope

### 5.1. Included Features

**Institutional website**

- Landing page that presents The Doghouse and a path to the members’ area
- Articles / blog readable without an account

**Accounts and access**

- Visitor → free member → member who paid for something
- Simple sign-in (email and/or Google or Facebook — exact mix in design)
- **Signed-in members** (free or paying) move from the site to the members’ area without signing in again; visitors who are not signed in still need to sign in

**Members’ area — calculator**

- Free useful version
- Full paid version

**Members’ area — workshops**

- At launch: **2 free** and **4 paid**, organised by breed
- Ability to sell; buyers keep access to purchased content (no v1 subscription)

**Members’ area — hotels**

- Map/list of pet-friendly hotels; open in native maps where useful

**Payments and invoicing**

- Charge for workshops / premium content
- Receipt/invoice **in for v1**, starting in trial/test mode if safer; fully live invoicing can follow later

**Deployment**

- Members’ area as installable web app and on phone (_iOS_ / _Android_) from the same codebase
- Publication path for the main app stores

### 5.2. Excluded Features (first version)

- Other brands or professional identities mixed into The Doghouse public materials
- In-product admin panel for editing all content
- Comments on articles
- Social features inside the product (likes, followers, profiles, in-product social network)
- Live support chat
- Languages other than English
- Expensive custom domain required at the start
- Advanced visit statistics / analytics beyond what is needed to operate carefully
- Clinic, shelter, or breeder **operations** tooling (audience is dog owners)
- Monthly subscription as the v1 commerce model

## 6. Technical Scope

### 6.1. Technology Stack

- **Backend:** _Go_
- **Frontend (website):** Pure _HTML_, _CSS_, _JavaScript_
- **Frontend (members’ area):** _Flutter_, compiled for the _Web_ (as a _PWA_), _iOS_, and _Android_ from the same codebase
- **Database:** _PostgreSQL_
- **Containerization:** _Docker_
- **Authentication:** _Magic links_ and/or social login (_Google_/_Facebook_) as chosen in design
- **Payments:** _Stripe_ (sandbox / trial as needed)
- **Invoicing:** _Moloni_ (trial/test mode for v1)
- **Maps:** multiplatform map package in _Flutter_; geolocation; hotels via _Overpass API_; geocoding (e.g. _Nominatim_) for text search

Detail and alternatives live in the research, requirements, and architecture documents.

### 6.2. External Services and Deployment

Prefer free or cheap plans that hold up. Typical choices for this project (subject to design updates):

- **Repository:** _GitHub_ (public) — secrets and private personal data stay out
- **Database:** persistent free-tier _PostgreSQL_ (e.g. _Neon_)
- **Backend:** container-friendly host (e.g. _Render_, _[Fly.io](https://fly.io/)_, or _Railway_)
- **Website and Flutter Web:** _Vercel_ or _Netlify_
- **Transactional email** for sign-in flows (e.g. _SendGrid_, _Mailgun_, or _Resend_)
- **Stripe** and **Moloni** in sandbox/trial for v1 as needed
- **Domain:** no expensive custom domain required at the start; free subdomains from hosts are acceptable

### 6.3. Delivery Sequence and Effort (summary)

Incremental deliveries keep the product usable early. Estimated effort for the whole *MVP* (including planning, design start, testing, write-up, and contingency) is about **515 hours** of work, on a **two-to-three-month** horizon. No currency amounts are quoted here.

| Delivery / package (build path) | Estimated hours |
| ------------------------------- | --------------- |
| 1 – Institutional website | 18 |
| 2 – Backend with authentication / members’ shell | 46 |
| 3 – Free calculator | 25 |
| 4 – Hotels map/list | 42 |
| 5 – Free workshops | 25 |
| 6 – Payments, premium content, invoicing (trial/test) | 72 |
| 7 – App-store publishing path | 24 |

The proposal report repeats this summary with planning, testing, and contingency totals and the proposed milestone weeks. The work breakdown lists every task behind these numbers.

### 6.4. Critical Product–Technical Constraints

- Hotel data: prefer stable public geospatial sources (e.g. _Overpass_ / _OpenStreetMap_) over scraping commercial sites.
- Seamless browsing: only for **signed-in** members between site and members’ area.
- Invoicing: in scope for v1 in trial/test mode; production tax setup can be a later step.
- Privacy and security: secure connections and careful handling of emails and payment details from day one (serious minimum; detail in design).

## 7. Learning Aims (repository)

Alongside the product, this public repository is used to practice:

- _Docker_, _Go_, passwordless and social authentication
- Payments and invoicing integrations in safe modes
- _Overpass_ / maps, _PWA_ installability, _Flutter_ multiplatform, store publishing
- Session continuity between the static site and the members’ area

These aims do not expand v1 into excluded features (section 5.2) and do not introduce other product brands into public materials.

## 8. Success and Failure

Aligned with the interview annex:

- **Success:** someone finds the site, sees the value, creates an account without hassle, uses what is free, buys a workshop, and finds useful hotels — on phone and on computer.
- **Failure:** something pretty that nobody can use; inability to sell; a map or workshops that help no one; a confusing or unprofessional message; other brands competing with The Doghouse in public docs or UI.

## 9. Conclusion

The Doghouse _MVP_ is a **real product for dog owners**, with a clear in/out list grounded in the [interview annex](INTERVIEW_ANNEX.md). The public repository also supports learning — without turning the project into a placeholder for another brand or an abstract exercise. Later design and implementation documents refine *how*; this Scope fixes *what* the first version must be.
