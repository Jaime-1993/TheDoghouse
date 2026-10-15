# The Doghouse

**A real product for dog owners**, a public learning ground, and a reusable technical skeleton — documented openly because the related private work cannot be.

## About

**The Doghouse** is a product for dog owners (site, articles, members’ area with calculator, workshops, and pet-friendly hotels) and at the same time a reusable skeleton and open simulation of engineering work that, in private, I continue for **Doses Pediátricas**. I own this repository and I decide scope. There is no external paying client for this public repo. I may name other brands in documentation to explain context. They do not appear in the shipping Doghouse UI or app. I may later publish engineering write-ups on **The Pharmacist, but tech**.

I ran a simulated product-owner interview; their answers are in the [interview annex](./docs/INTERVIEW_ANNEX.md) (questionnaire: [interview](./docs/00_INTERVIEW.md)). I spell out product boundaries and my learning aims in the [Scope](./docs/01_SCOPE.md).

- **Audience:** dog owners (not a clinic, shelter, or breeder operations tool)
- **Language:** English for site, app, and user-facing content
- **Repository:** public code and documentation; secrets and private personal data stay out

## Overview

The first version combines:

- **Institutional website** — landing page and articles (HTML/CSS/JS), strong on SEO
- **Members’ area** — one shared product on phone, computer browser, and installable web app (add to home screen), also aimed at the app stores
- **Three functional areas** — ideal weight calculator (free and paid full version), workshops (**2 free** and **4 paid** at launch, organised by breed), and a map/list of pet-friendly hotels

Signed-in members (free or paying) can move from the site to the members’ area without signing in again. Visitors who are not signed in still need to sign in. Selling workshops and premium content is in scope; receipt/invoice is in for v1 (trial/test mode first if safer). No in-product admin panel in the first version — content is placed directly into the product.

## Tech stack

| Layer | Technology |
| ----- | ---------- |
| Backend | Go |
| Frontend (website) | HTML, CSS, JavaScript |
| Frontend (members’ area) | Flutter (Web PWA, iOS, Android) |
| Database | PostgreSQL (Neon) |
| Containerization | Docker |
| Authentication | Magic links + social login (Google/Facebook) |
| Payments | Stripe (sandbox / trial as needed) |
| Invoicing | Moloni (trial/test mode for v1) |
| Maps | Overpass API + Nominatim |

## Key features

- **Ideal weight calculator** — useful free version; full version for who paid
- **Workshops** — free and paid videos organised by breed; buyers keep access to what they paid for (no monthly subscription in v1)
- **Pet-friendly hotels** — map/list to attract people and open places in the device’s maps app

## Documentation

Start with the interview pack, then the proposal documents. Full map: [`docs/README.md`](./docs/README.md).

- [Proposal report](./docs/reports/R1_PROPOSAL.md)
- [Interview questionnaire](./docs/00_INTERVIEW.md)
- [Interview annex (frozen product decisions)](./docs/INTERVIEW_ANNEX.md)
- [Scope](./docs/01_SCOPE.md)
- [Personas and flows](./docs/02_PERSONAS_AND_FLOWS.md)
- [Business rules](./docs/03_BUSINESS_RULES.md)
- [Work breakdown (WBS)](./docs/04_WBS.md)
- [Schedule (Gantt)](./docs/05_GANTT.md)
- [Research](./docs/06_RESEARCH.md)
- [Requirements](./docs/07_REQUIREMENTS.md)
- [Architecture](./docs/08_ARCHITECTURE.md)
- [Database](./docs/09_DATABASE.md)
- [API endpoints](./docs/10_API_ENDPOINTS.md)
- [UML diagrams](./docs/11_UML_DIAGRAMS.md)
- [Glossary](./docs/GLOSSARY.md)

Interview pack through Work breakdown are aligned; Schedule and the [proposal report](./docs/reports/R1_PROPOSAL.md) are on disk and still under review — see [`docs/README.md`](./docs/README.md). Design docs (`06`–`11`) may still need later review.

## Project status

| Area | Status |
| ---- | ------ |
| Public documentation (proposal track) | Interview through Work breakdown aligned; `05` and proposal report pending review |
| Institutional website | Live (landing + blog) |
| Backend / members’ area | Planned / in progress |
| Payments, invoicing, store publishing | Planned for the first version |

**Live website:** https://the-doghouse-iota.vercel.app/

Target horizon for a usable first version: on the order of **two to three months** of work, preferring quality over a rigid date that hurts the product (see the interview annex).

## Getting started

### Prerequisites

- Docker Desktop
- Go 1.23+ (for development)
- Flutter 3.24+ (for development)

### Running the project

1. **Start the backend and database:**

   ```bash
   docker compose up -d
   ```

   The API will be available at `http://localhost:8080` and the database at `localhost:5432`.

2. **Run the Flutter app (Web):**

   ```bash
   cd flutter_app
   flutter run -d chrome
   ```

3. **View the static website:**

   Live preview: https://the-doghouse-iota.vercel.app/

   Or serve it locally:

   ```bash
   cd web
   python3 -m http.server 3000
   ```

   Then open `http://localhost:3000` in your browser.

4. **Run website unit tests:**

   ```bash
   cd web
   npm test
   ```

### Testing the PWA

After building the Flutter app for web:

```bash
cd flutter_app
flutter build web
cd build/web
python3 -m http.server 8000
```

Then open `http://localhost:8000` in Chrome and look for the install icon in the address bar.

## License

MIT License – see [LICENSE](./LICENSE) for details.

---

**Questions or feedback?** Open an issue or reach out via GitHub.
