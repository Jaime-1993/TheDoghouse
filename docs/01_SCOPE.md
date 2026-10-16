# Scope Definition – _The Doghouse_

## 1. Introduction

This document establishes the scope of the Minimum Viable Product (_MVP_) for the project _The Doghouse_. The goal is a functional digital ecosystem shaped like a product for dog owners: a **public simulation** and learning ground, and a **reusable technical skeleton**. Commerce in this repository runs in **sandbox** so the sell path works as if it were real; reusers may point their own environment variables at live providers. The _MVP_ consists of an institutional website (_landing page_ and _blog_) and a members’ area developed in _Flutter_. The members’ area will be deployed to the _Web_ (as a _PWA_ – _Progressive Web App_), _iOS_, and _Android_ from the same codebase, without duplicating business logic or interface. That multiplatform approach is a central differentiator and part of what this project sets out to learn and demonstrate.

There is no external paying client for this public repository. I own the repository and decide the technical and learning boundaries of the work. _The Doghouse_ is the public product and documentation surface. In parallel it acts as an open simulation and reusable skeleton for private work on **Doses Pediátricas** ([Instagram](https://www.instagram.com/dosespediatricas/)), whose code and client data cannot be exposed here. Engineering write-ups may later appear on **The Pharmacist, but tech**. Other brands may be named in documentation when they explain why this repository exists. They must not appear in the production user interface or in the shipping _Doghouse_ application experience.

The project follows a _paper-first_ methodology: documentation and planning precede implementation so that technical and functional decisions are conscious and written down before code is produced. A **simulated client** interview (simulated product owner), of the same kind used for Doses Pediátricas, recorded the product answers in the interview annex. This Scope turns those product choices into the boundary of what the _MVP_ includes and excludes, and adds the technical and learning decisions that belong to me as the developer.

## 2. Motivation

The motivation for this project is threefold, and the three strands stand together.

First, there is a need for a public, reusable skeleton. A strong social-media presence and a real product such as Doses Pediátricas require authentication, payments, invoicing, multiplatform delivery, and careful handling of data. That real work stays private. _The Doghouse_ recreates the same class of problems in a domain that can be shown openly (dog care, workshops, pet-friendly hotels), so architecture and practice can be documented without leaking secrets. The same skeleton is meant to be adapted later to other real projects, including the private line of work already under way.

Second, there is a deliberately chosen learning agenda: _containerization_ with _Docker_, _backend_ development in _Go_, passwordless authentication (_magic links_) and social login, payment gateways (_Stripe_), invoicing (_Moloni_), the _Overpass API_, _Progressive Web Apps_, and above all _Flutter_ multiplatform delivery where one codebase serves _Web_, _iOS_, and _Android_. Those technologies are not optional flavouring. They are a core reason this project exists.

Third, there is the will to apply sound software engineering in the open, from requirements and modelling through _UML_, testing, and _cloud_ deployment, so that the result is both a usable product for dog owners and a credible portfolio piece.

## 3. Objectives

The _MVP_ objectives follow the _SMART_ methodology.

**Specific** — Build a working platform with an institutional website (_landing page_ and _blog_) and a _Flutter_ multiplatform members’ area with three domains (ideal weight calculator, workshops, maps), plus passwordless and social authentication, payments, and invoicing. The members’ area ships to _Web_ (as a _PWA_), _iOS_, and _Android_ from one codebase.

**Measurable** — The _MVP_ is complete when a dog owner can register and sign in via _magic link_ or social login, move from the static site to **Flutter Web** without signing in again when already authenticated (**native** iOS/Android apps authenticate **inside the app**), use free content, buy premium content via _Stripe_ **sandbox** (no real-money charges operated in this public project), receive a simulated receipt or invoice via _Moloni_ **sandbox**, and find pet-friendly hotels through the _Overpass API_ on an interactive map. Those flows must work on _Web_, _iOS_, and _Android_.

**Achievable** — With the chosen stack, free or low-cost persistent services, and the calendar rule below, the _MVP_ is feasible. Quality takes priority over a date that would damage the product. Wall-clock time may stretch because this public project shares my calendar with private client work and smaller freelance jobs; the public repo is what I want to show to other engineers and recruiters.

**Relevant** — The _MVP_ is a public product-shaped simulation for dog owners and at the same time a technical and methodological foundation that can be reused for private real projects such as Doses Pediátricas and for public engineering narrative on The Pharmacist, but tech.

**Time-bound** — **Calendar rule (same in Scope, schedule, and proposal report):** work is **solo**. A **usable first version** means core Deliveries **1–7** Done when (~**420 hours**); cross-cutting validation (~55 h) comes **after** that checkpoint. Solo hours add up: at **28 h/week**, ~420 h ≈ **15 weeks** (~**three and a half months** from S01); at **21 h/week**, ≈ **20 weeks** (~**four to five months**). Overlapping delivery bars do **not** cancel solo hours. **Two months** and any “three months by overlapping hours” claim are **not** published targets. Supporting closure documentation follows usable v1. Real dates may slip when private client or freelance work takes priority. Week tables live in the schedule.

## 4. Proposed Solution

The solution is a digital ecosystem with three main components.

### 4.1. Institutional Website (_Landing Page_ + _Blog_)

The site is built in pure _HTML_, _CSS_, and _JavaScript_, without heavy _frameworks_, to favour _SEO_ and fast loading. The _landing page_ presents _The Doghouse_ and a clear path into the members’ area. The _blog_ holds static articles on dog care and related topics, readable without an account, to attract organic traffic. Article comments are out of scope for the first version.

### 4.2. _Flutter_ Multiplatform Members’ Area (_Web_, _iOS_, _Android_)

The members’ area is developed in _Flutter_ and compiled for the three platforms from the same codebase, sharing business logic, data models, _API_ services, and interface. That choice removes duplicated effort and keeps behaviour consistent.

It contains three functional areas.

The **ideal weight calculator** lets the user pick a breed and enter age. The free version returns an approximate ideal weight. The paid full version returns a richer result (for example percentiles, growth curves, and dietary recommendations).

The **workshops** area is a video library organised by breed. At launch the inventory is two free videos and four paid videos. Purchase options include individual paid videos and _bundles_ (by breed, and a complete present set of then-existing paid videos). Buyers keep **lifetime access** to what they paid for. This proposal does **not** sell a SKU that promises unpublished future videos — post-launch editorial production is outside the effort estimate. There is no monthly subscription in the first version.

The **maps** area shows pet-friendly hotels from the _Overpass API_ on an interactive map, with geolocation when the user consents, and a control to open a place in the device’s native maps app. Text search via geocoding remains available when location is declined. Concrete map packages and geocoding services are chosen in design.

On the _Web_ the members’ area is configured as a _PWA_ (_service worker_ and _manifest.json_) so it can be installed from the browser. The same codebase is aimed at the _App Store_ and _Play Store_.

### 4.3. _Backend_ in _Go_ with _REST API_

A _REST_ _API_ in _Go_ covers user registration and authentication (_magic link_ and social login), content for breeds, workshops, and calculator data, _Stripe_ for payments in **sandbox** only in the first version, _Moloni_ for **simulated** receipts or invoices in **sandbox**, _Overpass_ queries for hotels, and transactional email for _magic links_. There is no in-product administration panel in the first version. Content is placed directly through files or the database.

## 5. Functional Scope

### 5.1. Included Features

**Institutional website**

- Institutional _landing page_
- Static _blog_ articles accessible without _login_

**Authentication and access**

- Registration with email
- Authentication via _magic link_
- Authentication via _Google_ and/or _Facebook_
- Access ladder of visitor, free member, and member who paid for something
- _Seamless_ transition from the static website to **Flutter Web** for **signed-in** members only (session sharing). **Native iOS/Android** apps authenticate **inside the app**; they do not inherit the static-site seamless cookie path
- Visitors who are not signed in must still sign in

**Calculator**

- Free basic ideal weight calculator
- Paid complete calculator

**Workshops**

- Free videos at launch (two)
- Paid videos at launch (four), organised by breed
- Purchase of individual videos and of _bundles_ (breed, complete present) as designed
- Lifetime access to purchased items without a v1 subscription (no SKU for unpublished future videos)

**Maps**

- Interactive map of pet-friendly hotels via _Overpass API_
- Geolocation with consent
- Open in native maps
- Text location search

**Payments and invoicing**

- Checkout via _Stripe_ for premium content (sandbox in this public project)
- Optional promotional **codes** and time-bounded automatic **campaigns** (do not stack; higher percentage wins; operated without an admin panel)
- Partial bundle upgrade at the **full catalogue price** of the bundle; only missing entitlements are granted
- Checkout at **0.00 EUR** grants access without a Stripe session and without a Moloni document
- Receipt or invoice via _Moloni_ **sandbox** (simulated documents; no legal/tax effect in this public project; reusers may configure live Moloni via environment variables)

**Deployment**

- _Flutter_ members’ area on _Web_ (_PWA_), _iOS_, and _Android_ from one codebase
- Store **publication path** exercised (Play as download channel; App Store submission best effort — approval does not block the rest of scope)

### 5.2. Excluded Features

- In-product administration panel for editing all content
- Traditional email-and-password authentication (forbidden in the first version; only _magic link_ and social login)
- _Blog_ comment system
- In-product social network features (likes, followers, profiles)
- Live support chat
- Languages other than English in the product
- Expensive custom domain required at the start
- Advanced visit analytics as a v1 requirement
- Clinic, shelter, or breeder **operations** tooling
- Other brands inside the shipping _Doghouse_ UI or app experience

## 6. Technical Scope

### 6.1. Technology Stack

- **Backend:** _Go_ (learning from scratch)
- **Frontend (website):** Pure _HTML_, _CSS_, _JavaScript_
- **Frontend (members’ area):** _Flutter_, compiled for _Web_ (_PWA_), _iOS_, and _Android_ from the same codebase
- **Database:** _PostgreSQL_
- **Containerization:** _Docker_ (learning from scratch)
- **Authentication:** _Magic links_ and social login (_Google_/_Facebook_) (learning from scratch). Email-and-password is out of scope
- **Payments:** _Stripe_ **sandbox** in this public project — no real-money charges operated here (learning from scratch; reusers may switch via environment variables)
- **Invoicing:** _Moloni_ **sandbox**, simulated documents in this public project (learning from scratch; reusers may switch via environment variables)
- **Maps:** Multiplatform map in _Flutter_, device geolocation, hotels via _Overpass API_, text geocoding (learning from scratch; package choices in design)

### 6.2. External Services and Deployment

Deployment prefers free or cheap plans that hold up for an _MVP_.

The public repository is on _GitHub_. Secrets and private personal data stay out of it. _Docker_ keeps development and production consistent. The database is expected on a persistent free-tier _PostgreSQL_ host such as _Neon_. The _Go_ _API_ runs on a container-friendly host such as _Render_, _Fly.io_, or _Railway_, accepting that some free tiers show _cold starts_. The static site and the _Flutter_ _Web_ _PWA_ sit on _Vercel_ or _Netlify_. Store builds use Apple and Google developer accounts. Transactional email for _magic links_ may use _SendGrid_, _Mailgun_, or _Resend_ on free tiers. _Stripe_ and _Moloni_ run in **sandbox** in this public project (no real-money charges; simulated invoices only). Live providers remain a **reuse** option via environment variables — see the business rules.

No expensive custom domain is required at the start. Free subdomains from the hosts are acceptable, for example separate hosts for the institutional site, the members’ _PWA_ (_Flutter Web_), and the _API_, so that session cookies or tokens can be shared carefully for seamless navigation of **signed-in** members between the **static site and Flutter Web** only. Native store builds authenticate inside the app.

### 6.3. Delivery Sequence

Deployment is incremental so each slice can be validated early. Effort detail (proposal estimate on the order of **~591 hours** including contingency), *Done when* criteria, and week-by-week planning live in the [work breakdown](04_WBS.md) and schedule. This Scope only names the intended order of deliveries.

- **Delivery 1** — Institutional website (_landing page_ and _blog_)
- **Delivery 2** — Base _backend_ with authentication and a members’ shell
- **Delivery 3** — Free calculator
- **Delivery 4** — Map with _Overpass API_ and geolocation
- **Delivery 5** — Free workshops
- **Delivery 6** — Payments, premium content (including _bundles_), and invoicing in _Stripe_/_Moloni_ **sandbox**
- **Delivery 7** — Store publishing path

Each delivery is tested in development and again after deployment. Supporting practices include _Docker_ consistency, _HTTPS_ on public endpoints, environment variables for secrets, a database decoupled from the _API_ container, and independent updates of site, _API_, and members’ area where possible.

### 6.4. Critical Technical Decisions

These decisions are part of the learning and delivery goals of the project.

- Hotel data comes from the _Overpass API_ (_OpenStreetMap_) with pet-friendly tags, not from scraping commercial hotel sites. Text search uses a proper geocoding service chosen in design.
- Hosting splits site and _PWA_ on static hosts, _Go_ on container hosts, and _PostgreSQL_ on a persistent free-tier service.
- _Moloni_ in this public project stays in **sandbox** (simulated documents). Live Moloni is optional for reusers via environment variables.
- Authentication for the first version is _magic link_ and social login only. Traditional email-and-password is forbidden.
- Secrets and integration settings (payments, invoicing, database, email, OAuth, Overpass) live in environment variables, never in the public repository.

## 7. Technologies to Learn

This project is deliberately built so that the following are practised in a real integrated product, not only in isolated tutorials.

- _Docker_ for development and production consistency
- _Go_ for the _REST API_ and external integrations
- _Magic links_ and social _OAuth_ login
- _Stripe_ **sandbox**, including _webhooks_ and purchase state (no real-money charges operated here)
- _Moloni_ **sandbox** for the simulated receipt or invoice path
- _Overpass API_ for geospatial hotel data
- _PWA_ installation (_service workers_, _manifest.json_)
- _Flutter_ multiplatform structure, builds, and store submission
- Maps in _Flutter_ with geolocation
- Seamless session sharing between the static site and **Flutter Web** on free subdomains (native apps authenticate inside the app)

Store publishing requires signing material (_iOS_ certificates, _Android_ keystore). The detailed steps belong in the work breakdown.

## 8. Conclusion

The _The Doghouse_ _MVP_ is an ambitious but bounded project. It must work as a product-shaped experience dog owners can walk through — including a sandbox buy path — and remain an honest learning vehicle and a reusable skeleton for private real work such as Doses Pediátricas and for public engineering narrative on The Pharmacist, but tech. This Scope is the base contract for later specification, design, implementation, and validation.

Shipping one _Flutter_ codebase to _Web_, _iOS_, and _Android_ is a central differentiator. Free and persistent services, **sandbox** commerce in this public simulation, and a public repository without secrets are conscious trade-offs that still teach the full sell-and-invoice path.

Meeting this scope means a usable multiplatform product under the solo calendar rule above (~**15 weeks** at 28 h/week or ~**20 weeks** at 21 h/week to Deliveries 1–7), practical exposure to the target technologies, and a skeleton robust enough to reuse beyond this public dog-care domain.
