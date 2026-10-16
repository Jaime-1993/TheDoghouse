# Proposal Report – The Doghouse

This report is a **self-contained** proposal snapshot. You should understand what I am building, why, what is in and out, how much effort I estimate, and how I map that effort onto calendar weeks — without opening other files. There is no external paying client and no commercial acceptance block. Identity, version, and publication status are in the **Document status** table at the end.

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

**Calendar rule (same as Scope and schedule):** work is **solo**. **Usable first version** = Deliveries **1–7** Done when (~**420 hours**); cross-cutting validation comes **after**. Solo hours add: **420 ÷ 28 ≈ 15 weeks** (~**three and a half months** from S01); **420 ÷ 21 = 20 weeks** (~**four to five months**). Overlapping delivery bars do **not** cancel solo hours. **Two months** is not a published target. Prefer quality over a harmful rigid date; freelance and private client weeks can stretch wall-clock further.

---

## 3. Starting decisions (simulated interview, summarised)

The simulated product owner decided, among other things:

- The product is called **The Doghouse**: institutional site plus members’ area for dog owners.
- They treat it as a **real product and business** brief — not an abstract exercise — and they decide product scope.
- **No other brands** in the site or app experience.
- Audience: **dog owners**; not clinic, shelter, or breeder operations software.
- Access: visitor → free member → member who paid for something. **No** in-product admin panel in the first version; content is placed directly.
- In scope: site and articles; shared members’ area on phone, browser, and installable web; calculator (free and paid full); workshops (**2 free** + **4 paid** at launch, by breed, with individual videos and breed / complete-present bundles — no future-video SKU); pet-friendly hotels map/list; simple sign-in; seamless **site ↔ Flutter Web** for **signed-in** members (native apps sign in inside the app); ability to sell; receipt/invoice in the first version; store **publication path** (Play download; App Store best effort).
- Out of scope for the first version: article comments; in-product social network; live chat; languages other than English; expensive custom domain required at the start.
- Money brief (owner voice): sell workshops and premium content; lifetime access per purchase; **no monthly subscription**; start low cost; they still speak of making money. Developer stance for this public repo: demonstrate that path in **sandbox**; live banking and fiscal invoicing are for reusers who configure their own environment, not an operating promise of this public simulation.
- Repository: **public** code and documentation; secrets and private personal data stay out.
- Operations: answer contacts when possible; no advanced visit analytics required in v1.

Tone: friendly and clear, like someone who likes animals. User-facing language: **English**.

---

## 4. Scope of work

### 4.1. Included

**Institutional website** — landing page and static blog articles (HTML/CSS/JS, SEO-friendly), with a clear path into the members’ area.

**Members’ area** — one Flutter product for Web (PWA), iOS, and Android: free and complete calculator; workshop library (**2 free** + **4 paid** at launch, by breed, with individual paid videos and breed / complete-present bundles — **no** SKU for unpublished future videos); hotels map/list from Overpass with consent-based geolocation and text search.

**Backend** — Go REST API for accounts, content access, sandbox payments, sandbox invoicing, hotel queries, and transactional email for magic links.

**Authentication** — magic link and/or Google and/or Facebook. Traditional email-and-password is out. Signed-in members move from the static site to Flutter Web without signing in again; visitors still must sign in. Native apps authenticate inside the app.

**Commerce (sandbox)** — Stripe sandbox checkout for premium SKUs; Moloni sandbox for simulated receipts/invoices (no legal/tax effect in this public project). Optional promotional **codes** and automatic **campaigns** (do not stack; higher percentage wins). Partial bundle upgrade at the **full catalogue price**; only missing entitlements are granted. Checkout at **0.00 EUR** grants access without Stripe or Moloni. No Apple/Google in-app purchase storefront for these SKUs in v1. Buyers keep lifetime access to what they purchased. Catalogue currency is **EUR** (numbers in §6).

**Stores** — exercise the **publication path** (Play as download channel; App Store submission best effort). Store approval does not block the rest of this proposal.

**Engineering practices** — Docker for consistency; public GitHub without secrets; unit and end-to-end tests on critical flows; a security pass when a delivery creates or changes an attack surface.

### 4.2. Delivery order

1. Institutional website  
2. Backend with authentication and members’ shell  
3. Free calculator  
4. Hotels map  
5. Free workshops  
6. Payments, premium content, sandbox invoicing  
7. Store publishing path  

After authentication is in place, calculator, map, and free workshops may share calendar focus, but solo hours still add. Payments depend on the free surface being ready. Planning and design sit before Deliveries 1–7; **validation (~55 h) sits after usable v1**; report and contingency close the full package.

### 4.3. Exclusions

Not in this proposal commitment: in-product admin UI; email-and-password auth; blog comments; in-product social features; live support chat; languages other than English in the product; expensive custom domain required at start; advanced analytics as a v1 requirement; clinic/shelter/breeder operations tooling; other brands in the shipping UI; monthly subscriptions; real-money Stripe charges or fiscal Moloni invoices **as operated by this public project** (reusers may enable live mode with their own secrets); editorial production beyond the launch workshop inventory (**2 free** + **4 paid**), including any “future video” catalogue promise; guaranteed App Store approval; detailed design lock of every API field and database table (that depth belongs in later design work, already budgeted as a package of hours below).

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

Commerce model: sell complete calculator, individual paid workshops, and workshop bundles (breed, complete present); buyers keep **lifetime access** to purchased items; **no** SKU for unpublished future videos; no monthly subscription in v1; no refunds for these purchases.

**Catalogue prices (EUR)** — product SKU prices for the sandbox checkout (not an author hourly rate or service fee):

| SKU | Price (EUR) |
| --- | ----------- |
| Complete calculator | 9.90 |
| Individual paid workshop video | 4.90 |
| Breed bundle | 12.90 |
| Complete present workshop bundle | 24.90 |

Free intros and the basic calculator remain 0.00. A checkout that resolves to 0.00 creates access without a Stripe session and without a Moloni document.

Sandbox: all paid checkouts in Stripe test mode; Moloni simulated PDFs with no legal value in this public project. Failed payment never unlocks. After sandbox confirmation, unlock only purchased entitlements; if invoice simulation fails after unlock, access stays and issuance is retried. Promotional codes and campaigns follow the stacking rule above; partial bundle purchases charge the full bundle catalogue price.

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

The calendar is a **reference map**, not a rigid contract of calendar days. It uses the **same calendar rule** as Scope and schedule (§2 above).

**Calendar anchor (S01):** week of **3 August 2026** (Mon 2026-08-03 – Sun 2026-08-09). Stance: forecast **as if starting from zero**. A live institutional site elsewhere does not shorten this proposal map; that progress is real, but this baseline does not spend the credit.

**Availability:** I work on The Doghouse in the time left after private client work and smaller freelance jobs. This repository is the public showcase for engineers and recruiters, so wall-clock delivery can stretch when client work takes priority. Hour totals do not change when that happens; end dates do.

| Pace | h/week | Usable v1 (~420 h) | Full package (~591 h) |
| ---- | ------ | ------------------ | --------------------- |
| Base (schedule map) | 21 | **~20 weeks** (S20, 14–20 Dec 2026) | **~29 weeks** (S29, 15–21 Feb 2027) |
| Higher capacity | 28 | **~15 weeks** (~9–15 Nov 2026) | **~21 weeks** (~late Dec 2026) |
| Lower capacity | 14 | **~30 weeks** | **~42 weeks** |

### Milestones (21 h/week map — windows match the schedule)

| Milestone | Window (start–end) |
| --------- | ------------------ |
| Proposal docs ready | 3–16 Aug 2026 (S01–S02) |
| Architecture and design validated | 10 Aug – 6 Sep 2026 (S02–S05) |
| Delivery 1 online (website) | 7–20 Sep 2026 (S06–S07) |
| Delivery 2 online (auth / members’ shell) | 14 Sep – 4 Oct 2026 (S07–S09) |
| Delivery 3 online (free calculator) | 28 Sep – 18 Oct 2026 (S09–S11) |
| Delivery 4 online (hotels map) | 12 Oct – 1 Nov 2026 (S11–S13) |
| Delivery 5 online (free workshops) | 26 Oct – 15 Nov 2026 (S13–S15) |
| Delivery 6 online (sandbox payments and premium) | 9 Nov – 13 Dec 2026 (S15–S19) |
| Delivery 7 available (store publication path) | 7–20 Dec 2026 (S19–S20) |
| **Usable first version (M9)** — Deliveries 1–7 only | **14–20 Dec 2026 (S20)** at 21 h/week |
| Beta hardened (validation) | 21 Dec 2026 – 10 Jan 2027 (S21–S23) |
| Final report / public write-up | 4–24 Jan 2027 (S23–S25) |
| Contingency closed / full package (M12) | 18 Jan – 21 Feb 2027 (S25–S29) |

Same-week handoffs in those windows match the schedule week table. Weekly capacity is planning bandwidth, not a leaf-by-leaf copy of the hour table.

---

## 9. Premises, planning risk, and scope changes

I assume solo work interleaved with private client and freelance projects; sandbox Stripe and Moloni for this public project; free or low-cost hosting that holds up for an MVP (accepting possible cold starts); secrets only in environment variables; a single decision-maker (me); and content created and placed without an admin panel.

**Planning risk I absorb** (no rewrite of this proposal’s commercial fiction — there is none): technical complexity I underestimated, defects of my own execution, slip from my own bad estimates, calendar stretch when client or freelance work takes the week, and small refinements that do not change the completion criteria above.

**Scope changes** that should trigger a conscious rewrite of this snapshot: new features or rule changes against the frozen brief; dropping sandbox for live money *as this public project’s operated mode*; adding admin UI, subscriptions, or other brands in the shipping UI; or expanding beyond the launch workshop inventory as a closed obligation.

Conscious parameters left for delivery time inside their hour envelopes: exact enabled mix of magic link / Google / Facebook; fine map package choices; App Store approval as best effort (Web PWA and Play download path still define store-line completion).

---

## 10. What “done” means for this proposal

At a high level, the **usable first version** is done when Deliveries **1–7** meet their Done when criteria: a dog owner can register and sign in, move from site to **Flutter Web** when already signed in (native apps sign in inside the app), use free content, complete a sandbox purchase (including code/campaign and partial-bundle rules) that unlocks only what was bought, see a simulated invoice path, and use the hotels map — with the launch workshop inventory and EUR catalogue above. **Validation (~55 h) is hardening after that checkpoint**, not part of the 420 h usable-v1 sum. Report and contingency close the full ~591-hour package.

This published snapshot replaces any earlier draft of the same report title. It does not invent a client signature.

---

## 11. Closing

I am proposing to build The Doghouse in public as a **simulation that behaves like a real product**: site, members’ area, sandbox commerce, and a reusable skeleton, for about **591 hours** of solo work including contingency, on a reference calendar anchored at **3 August 2026**, with usable v1 at **~15 weeks** of solo work at 28 h/week or **~20 weeks** at 21 h/week.

---

## Document status

| Field | Value |
| ----- | ----- |
| Document | Proposal report – first version (*MVP*) – The Doghouse |
| Project | The Doghouse |
| Document date | 2026-10-16 |
| Version | 1.1 |
| Status | Published |
| Author | Jaime Mendonça |
| Audience | Public repository visitors — engineers and recruiters |

**Notes:** Snapshot of the proposal track for a public sandbox simulation. No commercial acceptance checkboxes or signatures. Freeze basis: simulated product-owner interview answers dated 2026-10-13, interpreted for this repository as sandbox-operated commerce with a reusable skeleton. Product catalogue prices in EUR are SKU prices for that simulation, not author billing. Version **1.1** revises the solo calendar arithmetic, usable-v1 definition, annex decision F, and discount/bundle rules in this report.

---

*End of proposal report.*
