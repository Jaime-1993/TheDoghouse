# Schedule (Gantt) – _The Doghouse_

## 1. Introduction

This document turns the [work breakdown](04_WBS.md) (~**591 hours** including contingency) into a **week-by-week proposal calendar**. It is a **reference map**, not a rigid contract: weeks may shift if quality requires; product scope does not change without a new freeze in the interview annex / Scope / business rules.

Granularity: **weeks** (not days). Fine task lists live in a delivery roadmap when implementation of a delivery starts.

**Figure:** Mermaid Gantt below (milestones + major packages). If the figure and the tables disagree, the **tables win**.

---

## 2. Premises

| Item | Value |
| ---- | ----- |
| **Calendar anchor (S01)** | Week of **3 Aug 2026** (Mon **2026-08-03** – Sun **2026-08-09**) |
| **Effort source** | [WBS](04_WBS.md) grand total **~591 h** (subtotal ~505 + contingency 76 + unforeseen 10) |
| **Base capacity** | **3 h/day × up to 7 calendar days** ≈ **21 h/week** (planning reference) |
| Optimistic | **4 h/day** ≈ **28 h/week** |
| Pessimistic | **2 h/day** ≈ **14 h/week** |
| Work | Solo |
| Stance | Forecast **as if starting from zero** (no “already done” credits on this map) |
| Commerce | Stripe + Moloni **sandbox** only in v1 (`RN-19`…`RN-21`) |
| Auth / seamless | Magic link and/or Google and/or Facebook; seamless **site ↔ Flutter Web** for signed-in members (`RN-10`…`RN-13`) |
| Workshops | **2 free** + **4 paid** at launch, by breed |
| Brand in UI | **The Doghouse** only (`RN-03`) |

---

## 3. Scenarios and the annex horizon

### 3.1. Full package (~591 h)

| Scenario | h/week | Weeks ≈ | Approx. end (from S01) |
| -------- | ------ | ------- | ---------------------- |
| **Base (3 h/day)** | 21 | **~28–29** | **~mid-Feb 2027** (S29) |
| Optimistic (4 h/day) | 28 | ~21 | ~late Dec 2026 |
| Pessimistic (2 h/day) | 14 | ~42 | ~late May 2027 |

### 3.2. Annex / Scope “two to three months” vs this map

The interview annex and Scope target a **usable first version** (core Deliveries **1–7**) in about **two to three months** of focused work. That horizon is a **product goal**, not a claim that the **sequential** base map below fits inside 12–13 calendar weeks.

On this document’s **conservative sequential** map at **21 h/week**:

| Checkpoint | Meaning | Window (base) | Wall-clock from S01 |
| ---------- | ------- | ------------- | ------------------- |
| **M9 – Usable first version** | Deliveries **1–7** Done when | **S20** (~14–20 Dec 2026) | ~**20 weeks** (~**4–5 months**) |
| **M11 – Report & article** | Supporting closure docs | **S23–S25** (Jan 2027) | after M9 |
| **M12 – Full package** | + contingency / unforeseen | **S29** (~mid-Feb 2027) | ~**29 weeks** |

How the annex **2–3 months** can still hold without shrinking product scope:

1. **Parallelism** allowed by the WBS (D1 ∥ D2; after D2, **D3 ∥ D4 ∥ D5**) shortens wall-clock while total hours stay ~591.  
2. **Higher pace** (≥ **28 h/week**) compresses the same packages.  
3. Combining (1) and (2) is the realistic path toward the annex horizon for **M9**.

**Reading rule:** the week table in §5 is the **honest sequential baseline** (~4–5 months to M9 at 21 h/week). The annex **2–3 months** is the **target under parallelism and/or a faster weekly pace**. Prefer quality over a harmful rigid date.

**Usable vs supporting documentation:** annex/Scope “usable first version” = **M9**. Final report, glossary, and public write-up = **M11** (after validation). The full WBS including contingency = **M12**.

Rough sequential load to M9: planning + design **~105 h** + Deliveries 1–7 and cross-cutting code docs **~315 h** → **~420 h** by end of S20 at 21 h/week. Validation, report, and contingency continue after that.

---

## 4. Milestones (base scenario, chronological)

Milestones are numbered in **calendar order** on this sequential map (Delivery **4** before Delivery **5**).

| Milestone | Window (base) | Done when (summary) |
| --------- | ------------- | ------------------- |
| M0 – Proposal docs ready | S01–S02 | Scope, personas, business rules, WBS, schedule consistent with annex |
| M1 – Architecture & design validated | S02–S05 | Research, RF/RNF, architecture, DB, UML, API contracts, local skeletons |
| M2 – Delivery 1 online | S06–S07 | Landing + blog live; Playwright smoke green (`RN-03`, `RN-05`) |
| M3 – Delivery 2 online | S07–S09 | Auth + seamless site↔Flutter Web; unit + e2e + security green |
| M4 – Delivery 3 online | S09–S11 | Free calculator for signed-in users |
| M5 – Delivery 4 online | S11–S13 | Hotels map (viewport, TTL 24 h, consent) |
| M6 – Delivery 5 online | S13–S15 | Two free workshop intros |
| M7 – Delivery 6 online | S15–S19 | Sandbox Stripe/Moloni; premium unlock; no IAP |
| M8 – Delivery 7 available | S19–S20 | Store publishing path exercised |
| **M9 – Usable first version** | **S20** | Core Deliveries **1–7** complete per WBS Done when |
| M10 – Beta hardened | S21–S23 | Validation, security sweep, monitoring, rollback notes |
| M11 – Final report & article | S23–S25 | Report, glossary, public write-up |
| M12 – Contingency closed | S25–S29 | Buffer / unforeseen consumed or released |

Scope still allows **D3 ∥ D4 ∥ D5** after D2; dates above follow the sequential week table in §5.

---

## 5. Week-by-week map (base: 21 h/week)

**Capacity note:** the **h** column is **weekly capacity** for planning (~21 h), not a leaf-by-leaf reconciliation of WBS package hours. A short delivery (e.g. D1 ~23 h in the WBS) may still occupy **two** calendar weeks when that is the focus of those weeks. Package totals live in the [WBS](04_WBS.md); this table spreads focus across the calendar.

| Week | Dates | Focus | h | Cumulative ≈ |
| ---- | ----- | ----- | - | ------------ |
| **S01** | 3–9 Aug 2026 | Planning (Scope, personas, RN, WBS, schedule) | 21 | 21 |
| **S02** | 10–16 Aug 2026 | Planning (finish) + design start | 21 | 42 |
| **S03** | 17–23 Aug 2026 | Design (research, requirements, architecture) | 21 | 63 |
| **S04** | 24–30 Aug 2026 | Design (DB, UML, API) | 21 | 84 |
| **S05** | 31 Aug – 6 Sep 2026 | Design (env, skeletons, use-case diagram) — **M1** | 21 | 105 |
| **S06** | 7–13 Sep 2026 | **D1** Institutional website | 21 | 126 |
| **S07** | 14–20 Sep 2026 | D1 finish + **D2** auth start — **M2** | 21 | 147 |
| **S08** | 21–27 Sep 2026 | D2 auth / deploy | 21 | 168 |
| **S09** | 28 Sep – 4 Oct 2026 | D2 finish + **D3** free calculator start — **M3** | 21 | 189 |
| **S10** | 5–11 Oct 2026 | D3 free calculator | 21 | 210 |
| **S11** | 12–18 Oct 2026 | D3 finish + **D4** map start — **M4** | 21 | 231 |
| **S12** | 19–25 Oct 2026 | D4 hotels map | 21 | 252 |
| **S13** | 26 Oct – 1 Nov 2026 | D4 finish + **D5** free workshops start — **M5** | 21 | 273 |
| **S14** | 2–8 Nov 2026 | D5 free workshops | 21 | 294 |
| **S15** | 9–15 Nov 2026 | D5 finish + **D6** payments start — **M6** | 21 | 315 |
| **S16** | 16–22 Nov 2026 | D6 sandbox Stripe / Moloni / premium | 21 | 336 |
| **S17** | 23–29 Nov 2026 | D6 | 21 | 357 |
| **S18** | 30 Nov – 6 Dec 2026 | D6 | 21 | 378 |
| **S19** | 7–13 Dec 2026 | D6 finish + code docs + **D7** stores start — **M7** | 21 | 399 |
| **S20** | 14–20 Dec 2026 | D7 finish — **M8** / **M9 usable v1** | 21 | 420 |
| **S21** | 21–27 Dec 2026 | Validation / hardening (phase 4) | 21 | 441 |
| **S22** | 28 Dec 2026 – 3 Jan 2027 | Validation / hardening | 21 | 462 |
| **S23** | 4–10 Jan 2027 | Validation finish + report start — **M10** | 21 | 483 |
| **S24** | 11–17 Jan 2027 | Final report / article / glossary | 21 | 504 |
| **S25** | 18–24 Jan 2027 | Report finish + contingency — **M11** | 21 | 525 |
| **S26** | 25–31 Jan 2027 | Contingency buffer | 21 | 546 |
| **S27** | 1–7 Feb 2027 | Contingency buffer | 21 | 567 |
| **S28** | 8–14 Feb 2027 | Contingency + unforeseen | 21 | 588 |
| **S29** | 15–21 Feb 2027 | Unforeseen remainder — **M12** / **full package** | ~3 | **~591** |

Contingency (**76 h**) and unforeseen (**10 h**) are booked in **S25–S29** (not drawn as a single fake “task bar” in the figure).

---

## 6. Gantt figure (Mermaid)

```mermaid
gantt
    title The Doghouse – proposal calendar (base 21 h/week, from 2026-08-03)
    dateFormat  YYYY-MM-DD
    axisFormat  %b %d
    section Planning & design
    Planning (docs 00–05)           :p1, 2026-08-03, 14d
    Design (research→skeletons)     :p2, after p1, 28d
    Milestone M1 design validated   :milestone, m1, 2026-09-06, 0d
    section Deliveries 1–7
    D1 Website                      :d1, 2026-09-07, 14d
    Milestone M2 D1 online          :milestone, m2, 2026-09-20, 0d
    D2 Auth + seamless Web          :d2, 2026-09-14, 21d
    Milestone M3 D2 online          :milestone, m3, 2026-10-04, 0d
    D3 Free calculator              :d3, 2026-10-04, 14d
    Milestone M4 D3 online          :milestone, m4, 2026-10-18, 0d
    D4 Hotels map                   :d4, 2026-10-12, 21d
    Milestone M5 D4 online          :milestone, m5, 2026-11-01, 0d
    D5 Free workshops               :d5, 2026-10-26, 21d
    Milestone M6 D5 online          :milestone, m6, 2026-11-15, 0d
    D6 Payments sandbox + premium   :d6, 2026-11-09, 35d
    Milestone M7 D6 online          :milestone, m7, 2026-12-13, 0d
    D7 Store publishing             :d7, 2026-12-07, 14d
    Milestone M9 usable first version :milestone, m9, 2026-12-20, 0d
    section Closure
    Validation & hardening          :v1, 2026-12-21, 21d
    Report & public article         :r1, 2027-01-04, 21d
    Contingency & unforeseen        :c1, 2027-01-18, 35d
    Milestone M12 full package      :milestone, m12, 2027-02-17, 0d
```

_Figure 1 – Proposal Gantt (Mermaid). Bars are major packages; diamonds are milestones. Week-level capacity truth is in §5; package hours are in the WBS._

---

## 7. How to use this map

1. Treat **S01 = week of 3 Aug 2026** as the planning start of this proposal calendar.
2. At the start of each week, read **Sxx** and the matching WBS packages / *Done when*.
3. If effective hours fall below **21 h/week**, the end date slips (except intentional contingency burn).
4. Prefer quality over a harmful rigid date; do not change product scope here — freeze changes belong in the annex / Scope / business rules.
5. When opening a delivery for code, create a fine roadmap; keep unit + e2e (+ security when required) inside that delivery’s Done when.
6. To chase the annex **2–3 month** usable-v1 goal, prefer **parallel D3/D4/D5** and/or **≥28 h/week** rather than cutting Deliveries 1–7.

---

## 8. Conclusion

From **2026-08-03**, the **sequential** base map at **21 h/week** places **usable first version (M9 / Deliveries 1–7)** around **mid-December 2026 (S20)** and the **full proposal package (M12)** around **mid-February 2027 (S29)** — about **~591 hours** total. The annex **two-to-three-month** usable-v1 horizon remains the product target under **parallelism and/or a faster pace**. Optimistic/pessimistic weekly capacities rescale the same packages.

**Next:** keep the [proposal report](reports/R1_PROPOSAL.md) calendar and effort figures aligned with this schedule and the WBS; execution may still shift weeks without changing frozen product decisions.
