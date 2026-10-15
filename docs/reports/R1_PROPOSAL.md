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
- the ability to **sell** workshops and premium extras, with a **receipt/invoice in the first version** via Stripe and Moloni **sandbox** only (no real-money charges in v1).

The public **UI and app** use the name **The Doghouse only**. Public documentation may name related private context (for example Doses Pediátricas) where it helps a reader; that context does not appear in the shipping product UI.

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
| Brands | The Doghouse only in UI/app; docs may name related private context |
| Audience | Dog owners; not clinic/shelter/breeder ops |
| Access | Visitor / free / paid-per-purchase; no admin UI in v1 |
| In scope (v1) | Site + articles; shared members’ area on phone, browser, and installable web; calculator free + paid full; workshops **2 free** + **4 paid** by breed; hotels map/list; simple sign-in; seamless browsing for **signed-in** members; selling; receipt/invoice in **sandbox**; app stores |
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
3. **Backend** — *Go* *REST API* for accounts, content access, payments, invoicing (**sandbox** in v1), and hotel search integration.

Stack highlights (to be refined in later design work): *PostgreSQL*, *Docker*, magic link and/or social login, *Stripe* (**sandbox**), *Moloni* (**sandbox**), *Overpass* / *Nominatim* for hotels.

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
- Receipt/invoice **in for v1** via Stripe/Moloni **sandbox** only.  
- Geolocation only with consent; text search still works.  
- Public repository; no secrets in version control.  
- **The Doghouse** only in the shipping UI; related brands may appear in public docs as context.

---

## 7. Work, effort, and milestones

Effort is expressed in **hours of work**, not currency. Figures below match the work breakdown leaf totals: about **591 hours**, including contingency.

### 7.1. Effort by package

| Package | Estimated hours |
| ------- | --------------- |
| Planning and specification (scope, personas, RN, WBS, schedule) | 36 |
| Specification, design, and base scaffolding | 69 |
| Delivery 1 – Institutional website | 23 |
| Delivery 2 – Backend with authentication / members’ shell | 60 |
| Delivery 3 – Free calculator | 30 |
| Delivery 4 – Hotels map/list | 47 |
| Delivery 5 – Free workshops | 30 |
| Delivery 6 – Payments, premium content, invoicing (**sandbox**) | 86 |
| Delivery 7 – App-store publishing path | 28 |
| Cross-cutting source documentation | 11 |
| Testing, validation, and final deployment adjustments | 55 |
| Conclusions and public write-up | 30 |
| Contingency (~15%) + unforeseen | 86 |
| **Total (approx.)** | **~591** |

**Horizon:** the interview annex targets a **usable first version** (Deliveries 1–7) in about **two to three months** of focused work under **parallelism** (for example D3 ∥ D4 ∥ D5) and/or a stronger weekly pace. Prefer quality over a rigid date that hurts the product.

The schedule document also publishes a **conservative sequential** calendar at ~**21 h/week** from planning week **S01 = 3 Aug 2026**: usable v1 around **mid-December 2026**, full package (validation, report, contingency) around **mid-February 2027**. Weekly capacity in that map is planning bandwidth, not a leaf-by-leaf copy of the table above.

### 7.2. Proposed milestones (sequential baseline)

Calendar anchor **S01 = week of 3 Aug 2026**. Stance: proposal forecast **as if starting from zero** (the live institutional site is real progress; this baseline does not spend that credit on the map). Order: calculator → hotels → workshops (Deliveries 3 → 4 → 5).

| Milestone | Planned week (sequential, 21 h/week) |
| --------- | ----------------------------------- |
| Planning / proposal docs | week of 3 Aug 2026 (S01–S02) |
| Architecture and design validated | week of 31 Aug 2026 (S05) |
| Delivery 1 online (institutional website) | week of 14 Sep 2026 (also live today at https://the-doghouse-iota.vercel.app/) |
| Delivery 2 online (auth / members’ shell) | week of 28 Sep 2026 |
| Delivery 3 online (free calculator) | week of 12 Oct 2026 |
| Delivery 4 online (hotels map) | week of 26 Oct 2026 |
| Delivery 5 online (free workshops) | week of 9 Nov 2026 |
| Delivery 6 online (payments, premium, sandbox invoicing) | week of 7 Dec 2026 |
| Delivery 7 available (store publishing path) | week of 14 Dec 2026 |
| **Usable first version** (core deliveries complete) | **week of 14 Dec 2026** |
| Final report / public write-up | weeks of 4–18 Jan 2027 (after usable v1) |
| Contingency closed / full package | week of 15 Feb 2027 |

Execution may compress (parallelism / higher pace) or shift weeks if quality requires; product scope above does not change without a new freeze.

---

## 8. Current status (honest)

| Item | Status |
| ---- | ------ |
| Interview questionnaire and annex | Written and frozen for this proposal |
| Scope, personas, business rules, work breakdown, schedule | Written and aligned to the annex |
| This proposal report | On disk; effort/calendar refreshed to match WBS/~591 h and schedule (still under human review as a dossier) |
| Institutional website | **Live** — landing page and blog at https://the-doghouse-iota.vercel.app/ |
| Backend / members’ area / payments | Planned or in progress |
| Later design work (research, requirements, architecture, data, API, diagrams) | Draft material may exist; **not** part of this proposal package and may still change |

---

## 9. Closing

The Doghouse first version is proposed as a **usable product for dog owners** that can sell workshops and premium tools, documented in public under one brand, with learning aims stated beside — not instead of — the product. Build work should honour this proposal’s scope, rules, effort estimate, and milestone plan; finer technical design follows after the proposal package.
