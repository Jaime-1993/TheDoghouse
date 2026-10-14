# Proposal Report – The Doghouse

| Field | Value |
| ----- | ----- |
| **Document** | Proposal report – first version (*MVP*) |
| **Project** | The Doghouse |
| **Date** | 2026-10-14 |
| **Version** | 1.0 |
| **Status** | Published |
| **Author** | Jaime Mendonça (repository owner and product-scope decision maker) |
| **Audience** | Public readers of this repository; future implementers of the first version |
| **Freeze basis** | Product decisions in the project’s interview annex (2026-10-13) |
| **Language** | English |

This report is self-contained: a reader should understand the proposal — including effort and milestones — without opening other files. There is no external paying client and no acceptance-signature block.

---

## 1. What this product is

**The Doghouse** is a **real product and business for dog owners**. It combines:

- a **website** that presents the project and publishes articles;
- a **members’ area** with a weight calculator, video workshops, and a map/list of pet-friendly hotels;
- the ability to **sell** workshops and premium extras, with a **receipt/invoice in the first version** (trial/test mode first if safer).

The public name is **The Doghouse only**. No other brands or professional identities are mixed into the site, app, or public project documents.

The same public repository also supports learning and engineering practice. That does **not** turn the first version into an abstract exercise or a placeholder for another product.

---

## 2. Who it is for

| Role | Meaning |
| ---- | ------- |
| Primary | Dog owners |
| Secondary | People who only visit to read an article or see what the project is |
| Out of scope | Clinics, shelters, or breeders using this as **operations** software |

Access ladder at launch: **visitor** → **free member** → **member who paid for something**. There is no in-product admin panel in the first version; content is placed directly (files or database).

Tone: friendly and clear, like someone who likes animals, without unnecessary complexity. User-facing language: **English**.

---

## 3. Frozen product decisions (summary)

These decisions are frozen for the proposal. Fuller wording lives in the interview annex in this repository, for readers who want the question-and-answer record.

| Theme | Decision |
| ----- | -------- |
| Identity | Product name The Doghouse; site + members’ area |
| Nature | Real product/business; author = product owner |
| Brands | No other brands in public materials |
| Audience | Dog owners; not clinic/shelter/breeder ops |
| Access | Visitor / free / paid-per-purchase; no admin UI in v1 |
| In scope (v1) | Site + articles; shared members’ area on phone, browser, and installable web; calculator free + paid full; workshops **2 free** + **4 paid** by breed; hotels map/list; simple sign-in; seamless browsing for **signed-in** members; selling; receipt/invoice (trial OK); app stores |
| Out of scope (v1) | Article comments; in-product social network; live chat; languages other than English; expensive custom domain required at start |
| Money | Sell workshops/premium; buyers keep access; **no monthly subscription** in v1; start low cost |
| Repo | Public code and documentation; secrets and private personal data stay out |
| Ops | Author answers contacts when possible; no advanced analytics required in v1 |

**Success:** someone finds the site, sees value, creates an account without hassle, uses free tools, buys a workshop, and finds useful hotels — on phone and computer.  
**Failure:** something pretty nobody can use; inability to sell; useless map/workshops; confusing or unprofessional message; other brands competing with The Doghouse in public.

---

## 4. Solution outline

1. **Institutional website** — HTML/CSS/JS landing and articles (SEO-friendly), path into the members’ area.  
2. **Members’ area** — one shared *Flutter* product for Web (*PWA* / add to home screen), iOS, and Android.  
3. **Backend** — *Go* *REST API* for accounts, content access, payments, invoicing (trial/test allowed), and hotel search integration.

Stack highlights (to be refined in later design work): *PostgreSQL*, *Docker*, magic link and/or social login, *Stripe*, *Moloni* (trial/test), *Overpass* / *Nominatim* for hotels.

---

## 5. Personas and main journeys

- **Visitor** — site and articles; can start sign-in.  
- **Free member** — free calculator, **2 free** workshops, hotels; sees paid items locked.  
- **Paying member** — same as free, plus **only** what they purchased (kept access to those items); can view receipts/invoices.

Important journeys: sign-in; seamless site → members’ area for **signed-in** members only; use free content; buy premium; use calculator / workshops / hotels; handle payment or magic-link failures without fake unlocks.

---

## 6. Business rules (highlights)

- Access is **per purchase**, not a global “premium everything” flag.  
- Workshops at launch: **2 free** + **4 paid**, organised by breed.  
- Receipt/invoice **in for v1**, trial/test mode acceptable.  
- Geolocation only with consent; text search still works.  
- Public repository; no secrets in version control.  
- No other brands in public materials.

---

## 7. Work, effort, and milestones

Effort is expressed in **hours of work**, not currency. Figures below are the proposal estimate (leaf tasks in the work breakdown), totaling about **515 hours**, including contingency.

### 7.1. Effort by package

| Package | Estimated hours |
| ------- | --------------- |
| Planning and specification (scope, personas, WBS, schedule) | 28 |
| Specification, design start, and base scaffolding | 69 |
| Delivery 1 – Institutional website | 18 |
| Delivery 2 – Backend with authentication / members’ shell | 46 |
| Delivery 3 – Free calculator | 25 |
| Delivery 4 – Hotels map/list | 42 |
| Delivery 5 – Free workshops | 25 |
| Delivery 6 – Payments, premium content, invoicing (trial/test) | 72 |
| Delivery 7 – App-store publishing path | 24 |
| Cross-cutting source documentation | 11 |
| Testing, validation, and final deployment adjustments | 55 |
| Conclusions and public write-up | 30 |
| Contingency and final adjustments | 70 |
| **Total (approx.)** | **515** |

Horizon: on the order of **two to three months** of focused work for a usable first version, preferring quality over a rigid date that hurts the product. The calendar below is the **proposal plan** for that horizon.

### 7.2. Proposed milestones

Horizon counted from this report’s date (**2026-10-14**): about **two to three months** of remaining build for a usable first version. Only work already done sits in the past. Open milestones fall inside that horizon. Delivery order in this table matches the effort table above (calculator → hotels → workshops).

| Milestone | Planned week |
| --------- | ------------ |
| Architecture and specifications validation | **Done** — week of 3 Aug 2026 |
| Intermediate design checkpoint | **Done** — week of 10 Aug 2026 |
| Delivery 1 online (institutional website) | **Done** — week of 24 Aug 2026 (live at https://the-doghouse-iota.vercel.app/) |
| Proposal package published | **2026-10-14** (this report) |
| Delivery 2 online (auth / members’ shell) | week of 27 Oct 2026 |
| Delivery 3 online (free calculator) | week of 10 Nov 2026 |
| Delivery 4 online (hotels map) | week of 24 Nov 2026 |
| Delivery 5 online (free workshops) | week of 8 Dec 2026 |
| Delivery 6 online (payments, premium, invoicing trial) | week of 22 Dec 2026 |
| Delivery 7 available (store publishing path) | week of 5 Jan 2027 |
| Usable first version (core deliveries complete) | week of 12 Jan 2027 (within ~3 months of 14 Oct 2026) |
| Final report / public write-up | after usable v1 |

Execution may compress or shift weeks if quality requires; product scope above does not change without a new freeze.

---

## 8. Current status (honest)

| Item | Status |
| ---- | ------ |
| Interview questionnaire and annex | Written and frozen for this proposal |
| Scope, personas, business rules, work breakdown, schedule | Written and aligned to the annex |
| This proposal report | **Published** (version 1.0, 2026-10-14) |
| Institutional website | **Live** — landing page and blog at https://the-doghouse-iota.vercel.app/ |
| Backend / members’ area / payments | Planned or in progress |
| Later design work (research, requirements, architecture, data, API, diagrams) | Draft material may exist; **not** part of this proposal package and may still change |

---

## 9. Closing

The Doghouse first version is proposed as a **usable product for dog owners** that can sell workshops and premium tools, documented in public under one brand, with learning aims stated beside — not instead of — the product. Build work should honour this proposal’s scope, rules, effort estimate, and milestone plan; finer technical design follows after the proposal package.
