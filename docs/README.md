# Documentation – The Doghouse

This folder holds the written foundation of **The Doghouse**: what the product is meant to be, who it serves, how the work is broken down, and how that work is scheduled. The project follows a *paper-first* approach — planning and specification guide implementation — so these documents are meant to be read before the code, and to stay aligned with it as the product grows.

**The Doghouse** is one project with one author: a **real product and business** for dog owners, documented in public so the same repository can also support learning and engineering practice. There is no external paying client in these docs. The interview annex records product decisions in that author’s product-owner voice; the Scope is where product boundaries and any learning aims for the repository sit together.

The documentation is **under active development**. The package is being reorganised so that file names, numbering, and reading order stay consistent. This README is updated whenever documents here are created or changed, so that a visitor to the repository always sees a map that matches what is currently published.

Technical terms are introduced briefly the first time they appear, so the text stays readable whether you already know the jargon or not.

This index is **not** a commercial contract. It is a guide to the public documentation of that personal product-and-learning project. Files listed below with a link exist on disk today; that does **not** yet mean the proposal package is complete or finally numbered.

---

## How to read this package

### Target reading order (proposal)

When the proposal track is complete, read in this order — from kickoff decisions, through *what* and *who*, to *how* the work is organised in time, then the public proposal report:

1. **Interview** — structured questions and frozen product decisions (author as product owner) that ground the scope.  
2. **Scope** — what the minimum viable product (*MVP* — the smallest useful version of the product) includes and excludes.  
3. **Personas and flows** — who the product is for, and the main journeys those people take.  
4. **Business rules** — the rules the product must obey for the proposal commitment.  
5. **Work breakdown** — how the work is decomposed into deliveries, with effort and “done when” criteria.  
6. **Schedule** — milestones and the time map of those deliveries.  
7. **Proposal report (*R1*)** — a single self-contained public report under `reports/` (file: `R1_PROPOSAL.md`), once the documents above are aligned.

### Provisional order (what you can read today)

The **interview questionnaire** and the **interview annex** (answers and frozen decisions) are on disk. File names for `01`–`11` already follow the target order; [03_BUSINESS_RULES.md](03_BUSINESS_RULES.md) is a stub until content is moved in. You can start with [00_INTERVIEW.md](00_INTERVIEW.md) and [INTERVIEW_ANNEX.md](INTERVIEW_ANNEX.md), then Scope → Personas → Business rules → Work breakdown → Schedule — treating proposal **content** as still being aligned to the interview decisions.

After that track is ready, the proposal report in `reports/` will be the best single entry point for a complete overview.

Diagrams and other visual assets used by the documentation are kept in [`images/`](images/). A shared vocabulary is available in [`GLOSSARY.md`](GLOSSARY.md).

---

## Inventory

### Proposal documents (on disk today)

File **names and numbers** follow the matrix order. **Content** of Scope through Gantt is still being realigned to the interview decisions (A–K) and is not yet marked proposal-ready.

| Document | What it covers | Status |
| -------- | -------------- | ------ |
| [00_INTERVIEW.md](00_INTERVIEW.md) | Project interview questionnaire (questions only). | On disk |
| [INTERVIEW_ANNEX.md](INTERVIEW_ANNEX.md) | Answers and frozen product decisions (author as product owner). | On disk |
| [01_SCOPE.md](01_SCOPE.md) | Product goals, included and excluded scope, high-level solution outline, and success criteria for the *MVP*. | On disk (content to align) |
| [02_PERSONAS_AND_FLOWS.md](02_PERSONAS_AND_FLOWS.md) | User personas and the main flows (happy paths and important failure cases) across the website and the application. | On disk (content to align) |
| [03_BUSINESS_RULES.md](03_BUSINESS_RULES.md) | Business rules for the proposal commitment. | On disk (stub — content to move in) |
| [04_WBS.md](04_WBS.md) | Work breakdown structure (*WBS* — a hierarchical list of work packages): deliveries, effort estimates, and completion criteria. | On disk (content to align) |
| [05_GANTT.md](05_GANTT.md) | Schedule view: premises, milestones, and the temporal map of the deliveries. | On disk (content to align) |

### Not yet published (proposal track)

| Planned document | Role |
| ---------------- | ---- |
| `reports/R1_PROPOSAL.md` | Public proposal report (self-contained). The `reports/` folder is created when that file is first published. |

### Design documents (on disk)

These files belong to the **design** stage (after the proposal track). Names match the matrix order; content may still need later review.

| Document | What it covers |
| -------- | -------------- |
| [06_RESEARCH.md](06_RESEARCH.md) | Research and stack decisions. |
| [07_REQUIREMENTS.md](07_REQUIREMENTS.md) | Functional and non-functional requirements. |
| [08_ARCHITECTURE.md](08_ARCHITECTURE.md) | System architecture. |
| [09_DATABASE.md](09_DATABASE.md) | Data model. |
| [10_API_ENDPOINTS.md](10_API_ENDPOINTS.md) | *API* endpoint contracts. |
| [11_UML_DIAGRAMS.md](11_UML_DIAGRAMS.md) | UML diagrams. |

### Supporting

| Item | What it covers |
| ---- | -------------- |
| [images/](images/) | Figures and screenshots referenced by the documentation. |
| [GLOSSARY.md](GLOSSARY.md) | Definitions of technical terms used in the documentation. |

---

## Checklist – proposal package

Two columns matter: **on disk** (a file you can open today) versus **aligned** (reviewed and placed in the final proposal order). The proposal package is **not** ready until the aligned column is complete and `R1` is published.

| Item | On disk | Aligned to final proposal order |
| ---- | ------- | ------------------------------- |
| Interview questionnaire (`00_INTERVIEW`) | [x] | [ ] |
| Interview annex (`INTERVIEW_ANNEX`) | [x] | [ ] |
| Scope | [x] | [ ] |
| Personas and flows | [x] | [ ] |
| Business rules | [x] | [ ] |
| Work breakdown | [x] | [ ] |
| Schedule | [x] | [ ] |
| Public proposal report (`reports/R1_PROPOSAL.md`) | [ ] | [ ] |
| This README refreshed after each change above | — | [ ] (living document) |

---

## Open points

- The interview questionnaire and annex are published.  
- File names for `01`–`11` match the matrix order; `03_BUSINESS_RULES` is a stub until content is moved in.  
- Scope, personas, business rules, work breakdown, and schedule still need content alignment to the interview decisions before they count as proposal-ready.  
- The public proposal report (`R1`) is not yet published under `reports/`.

---

## Closing note

If you are new to the repository, start with the interview questionnaire and annex if you want the kickoff questions and answers, then the proposal files in order (`01`–`05`), and open `images/` when a figure is referenced — but treat proposal content as **still being aligned** to the interview. When the proposal track and the proposal report are ready, prefer the **target reading order** above; the report in `reports/` will then be the best single overview without opening every file.
