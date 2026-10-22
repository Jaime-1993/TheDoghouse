# Documentation – The Doghouse

This folder holds the written foundation of **The Doghouse**: what the product is meant to be, who it serves, how the work is broken down, and how that work is scheduled. The project follows a *paper-first* approach — planning and specification guide implementation — so these documents are meant to be read before the code, and to stay aligned with it as the product grows.

**The Doghouse** is my project: a **public product-shaped simulation** for dog owners, a **learning** vehicle, and a **reusable skeleton** documented in public (including context such as Doses Pediátricas) because related private work cannot be exposed here. Commerce in this repository runs in **sandbox**; reusers may switch providers via environment variables. There is no external paying client for this repository. The interview annex records answers from a **simulated product owner** (I ran the interview). The Scope is where I set the boundary of what the first version includes, excludes, and what I deliberately set out to learn.

The interview pack through Schedule and the proposal report are aligned. Design documents may still evolve. This README is updated when documents here change, so a visitor always sees a map that matches what is currently published.

Technical terms are introduced briefly the first time they appear, so the text stays readable whether you already know the jargon or not.

This index is **not** a commercial contract. It is a guide to the public documentation of that personal product-and-learning project. Interview through Schedule and the proposal report are aligned.

---

## How to read this package

### Target reading order (proposal)

Read in this order — from kickoff decisions, through *what* and *who*, to *how* the work is organised in time, then the public proposal report (or start with the report alone):

1. **Interview** — structured questions to a simulated product owner, and their frozen product decisions that ground the scope.  
2. **Scope** — what the minimum viable product (*MVP* — the smallest useful version of the product) includes and excludes.  
3. **Personas and flows** — who the product is for, and the main journeys those people take.  
4. **Business rules** — the rules the product must obey for the proposal commitment.  
5. **Work breakdown** — how the work is decomposed into deliveries, with effort and “done when” criteria.  
6. **Schedule** — milestones and the time map of those deliveries.  
7. **Proposal report** — a single self-contained public report under `reports/` ([`R1_PROPOSAL.md`](reports/R1_PROPOSAL.md)).

### Published reading order (today)

Start with [00_INTERVIEW.md](00_INTERVIEW.md), [INTERVIEW_ANNEX.md](INTERVIEW_ANNEX.md), [01_SCOPE.md](01_SCOPE.md), [02_PERSONAS_AND_FLOWS.md](02_PERSONAS_AND_FLOWS.md), [03_BUSINESS_RULES.md](03_BUSINESS_RULES.md), [04_WBS.md](04_WBS.md), [05_GANTT.md](05_GANTT.md), and the [proposal report](reports/R1_PROPOSAL.md) — those are aligned. File names for `01`–`11` follow the target order above. Design starts with [06_RESEARCH.md](06_RESEARCH.md) (**aligned**); `07`–`11` remain on disk and may still need review.

Screenshots and other non-generated visual assets are kept in [`images/`](images/). Generated diagram renders and their PlantUML sources (`diagrams/plantuml/`) live in [`diagrams/`](diagrams/). A shared vocabulary is available in [`GLOSSARY.md`](GLOSSARY.md).

---

## Inventory

### Proposal documents (on disk today)

File **names and numbers** follow the numbered reading order in this README. Interview through Schedule and the proposal report are aligned to the [frozen decisions in the interview annex](INTERVIEW_ANNEX.md) (owner voice) and the developer sandbox-simulation stance.

| Document | What it covers | Status |
| -------- | -------------- | ------ |
| [00_INTERVIEW.md](00_INTERVIEW.md) | Project interview questionnaire (questions only). | On disk (aligned) |
| [INTERVIEW_ANNEX.md](INTERVIEW_ANNEX.md) | Answers and frozen product decisions (simulated product-owner voice). | On disk (aligned) |
| [01_SCOPE.md](01_SCOPE.md) | Product goals, included and excluded scope, high-level solution outline, and success criteria for the *MVP*. | On disk (aligned) |
| [02_PERSONAS_AND_FLOWS.md](02_PERSONAS_AND_FLOWS.md) | User personas and the main flows (happy paths and important failure cases) across the website and the application. | On disk (aligned) |
| [03_BUSINESS_RULES.md](03_BUSINESS_RULES.md) | Business rules for the proposal commitment. | On disk (aligned) |
| [04_WBS.md](04_WBS.md) | Work breakdown structure (*WBS* — a hierarchical list of work packages): deliveries, effort estimates, and completion criteria. | On disk (aligned) |
| [05_GANTT.md](05_GANTT.md) | Schedule view: premises (~591 h, 21 h/week, S01 = 3 Aug 2026), scenarios, milestones, week map, and Mermaid figure. | On disk (aligned) |

### Proposal report

| Document | What it covers | Status |
| -------- | -------------- | ------ |
| [reports/R1_PROPOSAL.md](reports/R1_PROPOSAL.md) | Self-contained public proposal overview (simulation stance, scope, rules, effort, calendar). | On disk (aligned) |

### Design documents (on disk)

These files belong to the **design** stage (after the proposal track). Names match the numbered reading order in this README.

| Document | What it covers | Status |
| -------- | -------------- | ------ |
| [06_RESEARCH.md](06_RESEARCH.md) | Market alternatives → numbered lessons for the planned first version. | On disk (**aligned**) |
| [07_REQUIREMENTS.md](07_REQUIREMENTS.md) | Functional and non-functional requirements. | On disk (may need later review) |
| [08_ARCHITECTURE.md](08_ARCHITECTURE.md) | System architecture. | On disk (may need later review) |
| [09_DATABASE.md](09_DATABASE.md) | Data model. | On disk (may need later review) |
| [10_API_ENDPOINTS.md](10_API_ENDPOINTS.md) | *API* endpoint contracts. | On disk (may need later review) |
| [11_UML_DIAGRAMS.md](11_UML_DIAGRAMS.md) | UML diagrams. | On disk (may need later review) |

### Supporting

| Item | What it covers |
| ---- | -------------- |
| [images/](images/) | Screenshots and other assets that are not PlantUML renders. |
| [diagrams/](diagrams/) | Generated diagram images; PlantUML sources under `diagrams/plantuml/`. |
| [GLOSSARY.md](GLOSSARY.md) | Definitions of technical terms used in the documentation. |

---

## Checklist – proposal package

Two columns matter: **on disk** (a file you can open today) versus **aligned** (reviewed and accepted for the proposal track). The proposal package is ready when both columns are complete for the rows below.

| Item | On disk | Aligned |
| ---- | ------- | ------- |
| Interview questionnaire (`00_INTERVIEW`) | [x] | [x] |
| Interview annex (`INTERVIEW_ANNEX`) | [x] | [x] |
| Scope | [x] | [x] |
| Personas and flows | [x] | [x] |
| Business rules | [x] | [x] |
| Work breakdown | [x] | [x] |
| Schedule | [x] | [x] |
| Public proposal report (`reports/R1_PROPOSAL.md`) | [x] | [x] |
| This README refreshed after each change above | — | [x] (living document) |

---

## Open points

- Interview pack through Schedule and the proposal report are aligned (simulated product-owner interview; developer docs and R1 as a public sandbox simulation / reusable skeleton).  
- File names for `01`–`11` match the numbered reading order in this README.  
- Research (`06_RESEARCH.md`) is **aligned** for the design stage. Remaining design documents (`07`–`11`) may still need later review; they are not part of the proposal package.

---

## Closing note

If you are new to the repository, start with the interview questionnaire, annex, Scope, Personas and flows, Business rules, Work breakdown, Schedule, and the proposal report — or start with the report alone. Design documents (`06`–`11`) come after the proposal track.
