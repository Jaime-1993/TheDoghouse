# Proposal Report – The Doghouse

| Field | Value |
| ----- | ----- |
| **Document** | Proposal report – first version (*MVP*) |
| **Project** | The Doghouse |
| **Date** | 2026-10-14 |
| **Version** | 1.0 |
| **Author** | Jaime Mendonça |
| **Audience** | Public repository visitors — engineers and recruiters |

This report is a **self-contained** proposal snapshot. You should understand what I am building, why, what is in and out, how much effort I estimate, and how I map that effort onto calendar weeks — without opening other files. There is no external paying client and no commercial acceptance block.

---

## 1. What this document is

The Doghouse is a **public simulation** of product-and-engineering work: a website and a members’ area shaped like a real product for dog owners, with authentication, payments, invoicing, workshops, a calculator, and a hotels map. In this repository I run commerce through **Stripe** and **Moloni** in **sandbox** so the full sell-and-invoice path works *as if* it were real, without charging real money or issuing fiscal invoices. If someone reuses this skeleton later, they can point their own secrets and environment variables at live providers and operate for real — that reuse path is intentional; it is not what this public project itself commits to operate.

A short context paragraph: related private work (for example **Doses Pediátricas**) cannot be exposed here. This public dog-care domain lets me practise the same class of problems in the open. Engineering narrative may later appear under **The Pharmacist, but tech**. Those names may appear in documentation for context; they do not appear in the shipping Doghouse user interface.

I ran a **simulated product-owner interview** and froze the product answers in an interview annex in this repository. The simulated owner speaks as if they want a real business that sells. I keep those answers as the product brief. As the developer of this public repo, I implement that brief as a sandbox simulation and a reusable skeleton.

This proposal covers planning through a usable first version and its supporting closure work. Finer design documents (research, detailed requirements, architecture, data model, API contracts, UML) may still evolve after this snapshot; the hour estimate below already includes a design-and-scaffolding package, not a separate unpaid “phase zero”.

---

## 2. Objectives and success

I want a usable multiplatform product that a dog owner can actually walk through: find the site, create an account without friction, use free tools, buy premium content through a sandbox checkout, receive a simulated receipt or invoice, and find pet-friendly hotels — on phone and on computer, from one Flutter codebase aimed at Web (installable progressive web app), iOS, and Android.

Success, for this proposal, means those flows work end to end in sandbox. Failure would be a pretty shell nobody can use, a sell path that does not unlock what was “bought”, a map or workshops that help no one, or other brands leaking into the Doghouse UI.

The simulated owner asked for something usable on the order of **two to three months** of focused work, preferring quality over a rigid date that hurts the product. I keep that as the product-horizon target under parallelism and/or a stronger weekly pace. The conservative sequential calendar later in this report is longer; both readings are intentional.

---

## 3. Starting decisions (simulated interview, summarised)

The simulated product owner decided, among other things:

- The product is called **The Doghouse**: institutional site plus members’ area for dog owners.
- They treat it as a **real product and business** brief — not an abstract exercise — and they decide product scope.
- **No other brands** in the site or app experience.
- Audience: **dog owners**; not clinic, shelter, or breeder operations software.
- Access: visitor → free member → member who paid for something. **No** in-product admin panel in the first version; content is placed directly.
- In scope: site and articles; shared members’ area on phone, browser, and installable web; calculator (free and paid full); workshops (**2 free** + **4 paid** at launch, by breed, with individual videos and bundles); pet-friendly hotels map/list; simple sign-in; seamless site ↔ members’ area for **signed-in** members; ability to sell; receipt/invoice in the first version; app-store path.
- Out of scope for the first version: article comments; in-product social network; live chat; languages other than English; expensive custom domain required at the start.
- Money brief (owner voice): sell workshops and premium content; lifetime access per purchase; **no monthly subscription**; start low cost; they still speak of making money. Developer stance for this public repo: demonstrate that path in **sandbox**; live banking and fiscal invoicing are for reusers who configure their own environment, not an operating promise of this public simulation.
- Repository: **public** code and documentation; secrets and private personal data stay out.
- Operations: answer contacts when possible; no advanced visit analytics required in v1.

Tone: friendly and clear, like someone who likes animals. User-facing language: **English**.

---

## 4. Scope of work

### 4.1. Included

**Institutional website** — landing page and static blog articles (HTML/CSS/JS, SEO-friendly), with a clear path into the members’ area.

**Members’ area** — one Flutter product for Web (PWA), iOS, and Android: free and complete calculator; workshop library (**2 free** + **4 paid** at launch, by breed, with individual paid videos and bundles — breed, complete present, lifetime); hotels map/list from Overpass with consent-based geolocation and text search.

**Backend** — Go REST API for accounts, content access, sandbox payments, sandbox invoicing, hotel queries, and transactional email for magic links.

**Authentication** — magic link and/or Google and/or Facebook. Traditional email-and-password is out. Signed-in members move from the static site to Flutter Web without signing in again; visitors still must sign in. Native apps authenticate inside the app.

**Commerce (sandbox)** — Stripe sandbox checkout for premium SKUs; Moloni sandbox for simulated receipts/invoices (no legal/tax effect in this public project). No Apple/Google in-app purchase storefront for these SKUs in v1. Buyers keep lifetime access to what they purchased. Catalogue currency is **EUR** (numbers in §6).

**Stores** — exercise the publishing path to the main app stores as far as viable.

**Engineering practices** — Docker for consistency; public GitHub without secrets; unit and end-to-end tests on critical flows; a security pass when a delivery creates or changes an attack surface.

### 4.2. Delivery order

1. Institutional website  
2. Backend with authentication and members’ shell  
3. Free calculator  
4. Hotels map  
5. Free workshops  
6. Payments, premium content, sandbox invoicing  
7. Store publishing path  

After authentication is in place, calculator, map, and free workshops may run in parallel. Payments depend on the free surface being ready. Planning, design, validation, and a final report sit around those deliveries in the effort table.

### 4.3. Exclusions

Not in this proposal commitment: in-product admin UI; email-and-password auth; blog comments; in-product social features; live support chat; languages other than English in the product; expensive custom domain required at start; advanced analytics as a v1 requirement; clinic/shelter/breeder operations tooling; other brands in the shipping UI; monthly subscriptions; real-money Stripe charges or fiscal Moloni invoices **as operated by this public project** (reusers may enable live mode with their own secrets); infinite editorial production beyond the launch workshop inventory; detailed design lock of every API field and database table (that depth belongs in later design work, already budgeted as a package of hours below).

---

## 5. Users and main journeys

Three figures cover the product.

The **visitor** reads the site and articles and may start sign-in. They do not use calculator, workshops, hotels, profile, purchase, or invoices until authenticated.

The **free member** is signed in: basic calculator, two free workshop intros, hotels map; paid items stay visible but locked.

The **member who paid for something** keeps lifetime access **only** to what they bought. There is no global “premium everything” flag. Calculator and workshops are independent catalogues.

Happy paths: sign in with magic link or social login; seamless site → Flutter Web when already signed in; use free content; buy a SKU in sandbox and unlock it; use calculator, workshops, or hotels; open a hotel in the device maps app.

Failure paths: expired or reused magic link requires a new request; failed payment must not unlock content or look like a successful invoice; delayed payment confirmation must not leave a successful payer locked out after the webhook is handled; re-purchase of an identical owned SKU is refused.

---

## 6. Material business rules (highlights)

Identity: The Doghouse only in the shipping UI. English. Dog owners, not clinic ops.

Access: visitor / free / paid-per-purchase. No admin panel in v1.

Auth: magic link (fifteen minutes, single use) and/or Google/Facebook; JWT session about seven days; seamless site ↔ Flutter Web for signed-in members only.

Commerce model: sell complete calculator, individual paid workshops, and workshop bundles; lifetime access; no monthly subscription in v1; no refunds for these purchases.

**Catalogue prices (EUR)** used by the sandbox checkout (illustrative product catalogue for this simulation):

| SKU | Price (EUR) |
| --- | ----------- |
| Complete calculator | 9.90 |
| Individual paid workshop video | 4.90 |
| Breed bundle | 12.90 |
| Complete present workshop bundle | 24.90 |
| Lifetime workshop bundle | 49.90 |

Free intros and the basic calculator remain 0.00. A checkout that resolves to 0.00 creates access without a Stripe session and without a Moloni document.

Sandbox: all paid checkouts in Stripe test mode; Moloni simulated PDFs with no legal value in this public project. Failed payment never unlocks. After sandbox confirmation, unlock only purchased entitlements; if invoice simulation fails after unlock, access stays and issuance is retried.

Hotels: available to all signed-in members; Overpass pet-friendly tags; viewport queries; optional 24-hour cache; geolocation only with consent.

Public repository: secrets in environment variables, never in the repo.

---

## 7. Work breakdown and effort

Effort is in **hours of solo work**, not currency. There is no hourly rate, no contingency in euros, and no payment schedule — this is a personal public project.

I estimate about **505 hours** of planned work packages, plus **76 hours** contingency (~15% of that subtotal) and **10 hours** unforeseen adjustments — about **591 hours** in total. Roughly one fifth of the implementation-heavy work sits in automated tests.

| Package | Estimated hours |
| ------- | --------------- |
| Planning and specification (interview, scope, personas, rules, breakdown, schedule) | 36 |
| Specification, design start, and base scaffolding | 69 |
| Delivery 1 – Institutional website | 23 |
| Delivery 2 – Backend with authentication / members’ shell | 60 |
| Delivery 3 – Free calculator | 30 |
| Delivery 4 – Hotels map/list | 47 |
| Delivery 5 – Free workshops | 30 |
| Delivery 6 – Payments, premium content, sandbox invoicing | 86 |
| Delivery 7 – App-store publishing path | 28 |
| Cross-cutting source documentation | 11 |
| Testing, validation, and deployment hardening | 55 |
| Conclusions, report, and public write-up | 30 |
| **Subtotal** | **~505** |
| Contingency (~15%) | 76 |
| Unforeseen final adjustments | 10 |
| **Grand total** | **~591** |

Planning and design hours are **inside** this total. They are not a separate commercial add-on.

---

## 8. Reference calendar

The calendar is a **reference map**, not a rigid contract of calendar days. Base capacity for planning is about **3 hours per day** across up to seven calendar days — about **21 hours per week**. Optimistic pace ~28 h/week; pessimistic ~14 h/week.

**Calendar anchor (S01):** week of **3 August 2026** (Monday 2026-08-03). Stance: forecast **as if starting from zero**. Any work already done in the real world does not shorten this proposal map.

**Availability:** I work on The Doghouse in the time left after private client work and smaller freelance jobs. This repository is the piece I want to show publicly to engineers and recruiters, so wall-clock delivery can stretch when client work takes priority. The hour totals below do not change when that happens; the end dates do.

On the **conservative sequential** map at 21 h/week, usable first version (Deliveries 1–7) lands around **mid-December 2026** (~week S20), and the full package including validation, report, and contingency around **mid-February 2027** (~week S29). That sequential path is about **four to five months** to usable v1 — longer than the simulated owner’s **two-to-three-month** horizon. The shorter horizon remains the product target if I run allowed parallelism (for example calculator ∥ map ∥ free workshops after auth) and/or a stronger weekly pace. Prefer quality over a harmful rigid date; expect further slip when freelance or private client work crowds the calendar.

| Scenario (full ~591 h) | h/week | Approx. horizon from S01 |
| ---------------------- | ------ | ------------------------ |
| Base | 21 | ~28–29 weeks (~mid-Feb 2027) |
| Optimistic | 28 | ~21 weeks |
| Pessimistic | 14 | ~42 weeks |

### Milestones (sequential baseline)

| Milestone | Planned window (base) |
| --------- | --------------------- |
| Proposal docs ready | weeks of 3–16 Aug 2026 |
| Architecture and design validated | week of 31 Aug 2026 |
| Delivery 1 online (website) | week of 14 Sep 2026 |
| Delivery 2 online (auth / members’ shell) | week of 28 Sep 2026 |
| Delivery 3 online (free calculator) | week of 12 Oct 2026 |
| Delivery 4 online (hotels map) | week of 26 Oct 2026 |
| Delivery 5 online (free workshops) | week of 9 Nov 2026 |
| Delivery 6 online (sandbox payments and premium) | week of 7 Dec 2026 |
| Delivery 7 available (store path) | week of 14 Dec 2026 |
| **Usable first version** | **week of 14 Dec 2026** |
| Final report / public write-up | weeks of early–mid Jan 2027 |
| Contingency closed / full package | week of 15 Feb 2027 |

Weekly capacity on that map is planning bandwidth, not a leaf-by-leaf copy of the hour table. Weeks may shift; frozen product decisions above do not change without a new freeze of the interview answers and this proposal’s substance.

---

## 9. Premises, planning risk, and scope changes

I assume solo work interleaved with private client and freelance projects; sandbox Stripe and Moloni for this public project; free or low-cost hosting that holds up for an MVP (accepting possible cold starts); secrets only in environment variables; a single decision-maker (me); and content created and placed without an admin panel.

**Planning risk I absorb** (no rewrite of this proposal’s commercial fiction — there is none): technical complexity I underestimated, defects of my own execution, slip from my own bad estimates, calendar stretch when client or freelance work takes the week, and small refinements that do not change the completion criteria above.

**Scope changes** that should trigger a conscious rewrite of this snapshot: new features or rule changes against the frozen brief; dropping sandbox for live money *as this public project’s operated mode*; adding admin UI, subscriptions, or other brands in the shipping UI; or expanding beyond the launch workshop inventory as a closed obligation.

Conscious parameters left for delivery time inside their hour envelopes: exact enabled mix of magic link / Google / Facebook; fine map package choices; App Store approval as best effort (Web PWA and Play download path still define store-line completion).

---

## 10. What “done” means for this proposal

At a high level, the usable first version is done when a dog owner can register and sign in, move from site to members’ area when already signed in, use free content, complete a sandbox purchase that unlocks only what was bought, see a simulated invoice path, and use the hotels map — on Web, iOS, and Android paths in scope — with the launch workshop inventory and EUR catalogue above. Supporting report and contingency close the full ~591-hour package.

This published snapshot replaces any earlier draft of the same report title. It does not invent a client signature.

---

## 11. Closing

I am proposing to build The Doghouse in public as a **simulation that behaves like a real product**: site, members’ area, sandbox commerce, and a reusable skeleton, for about **591 hours** of solo work including contingency, on a reference calendar anchored at **3 August 2026**, with a two-to-three-month usable-v1 target under parallelism or a faster pace, and a longer honest sequential baseline at twenty-one hours per week.

---

## Document status

| Field | Value |
| ----- | ----- |
| Document | Proposal report – The Doghouse (this document, v1.0, 2026-10-14) |
| Status | Published |
| Author | Jaime Mendonça |
| Audience | Public repository visitors — engineers and recruiters |

**Notes:** Snapshot of the proposal track for a public sandbox simulation. No commercial acceptance checkboxes or signatures. Freeze basis: simulated product-owner interview answers dated 2026-10-13, interpreted for this repository as sandbox-operated commerce with a reusable skeleton. Document identity (title, version, date) is in the opening table; this block records publication status only.

---

*End of proposal report.*
