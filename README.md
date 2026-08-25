# The Doghouse

**A learning MVP for a dog care ecosystem — this skeleton will serve as the technical foundation for a real-world pharmacy application.**

## About This Project

**The Doghouse** is a hands-on learning project by **Jaime Mendonça**, a Software Engineer who is also a Pharmacist, combining technical expertise with healthcare domain knowledge.

- **Duration:** 17 weeks (July 27 – November 23, 2026)
- **Purpose:** Master modern technologies (Flutter, Go, Docker, authentication, payments, invoicing, maps, SEO, PWA deployment)
- **Outcome:** A reusable technical skeleton for future production projects

## Real-World Application

The architecture, authentication flow, payment logic, and deployment patterns developed in this MVP will be adapted for a production project:

**[Doses Pediátricas](https://www.instagram.com/dosespediatricas/)** – a pediatric dosage calculator created by pharmacists, for parents and healthcare professionals.

**Important note:** This repository shows the **development process** and the **technical skeleton**. The actual production code for Doses Pediátricas is private and contains client-specific data. The Doghouse serves as the public-facing demonstration of the work, with no sensitive client information exposed.

## Why The Doghouse?

The Doghouse uses a dog care ecosystem as its domain model. This approach allows for a complete demonstration of production-grade architecture (calculators, workshops, e-commerce, maps, authentication, payments) while maintaining strict confidentiality for the real-world client project. It is a fully functional, open-source portfolio piece with no sensitive information exposed.

## Overview

The Doghouse is a Minimum Viable Product (MVP) that combines:

- **Institutional Website** – landing page + blog, pure HTML/CSS/JS for SEO
- **Flutter Application** – deployed to Web (PWA), iOS, and Android from a single codebase
- **Three Functional Areas** – ideal weight calculator, video workshops, interactive map with pet-friendly hotels

## Tech Stack

| Layer                  | Technology                                   |
| ---------------------- | -------------------------------------------- |
| Backend                | Go                                           |
| Frontend (Website)     | HTML, CSS, JavaScript                        |
| Frontend (Application) | Flutter (Web PWA, iOS, Android)              |
| Database               | PostgreSQL (Neon)                            |
| Containerization       | Docker                                       |
| Authentication         | Magic links + Social login (Google/Facebook) |
| Payments               | Stripe (sandbox)                             |
| Invoicing              | Moloni (sandbox)                             |
| Maps                   | Overpass API + Nominatim                     |

## Key Features

- **Ideal Weight Calculator** – Free and premium versions with breed-based recommendations
- **Workshops Area** – Free introductory videos + paid content (individual videos, breed bundles, complete present bundle, lifetime bundle)
- **Interactive Map** – Pet-friendly hotels via Overpass API with dynamic viewport and geolocation

## Documentation

Complete project documentation is available in the `docs/` folder:

- [Scope Definition](./docs/01_SCOPE.md)
- [User Personas and Flows](./docs/02_PERSONAS_AND_FLOWS.md)
- [Work Breakdown Structure (WBS)](./docs/03_WBS.md)
- [Gantt Chart](./docs/04_GANTT.md)
- [Research and Analysis](./docs/05_RESEARCH.md)
- [Requirements](./docs/06_REQUIREMENTS.md)
- [Architecture](./docs/07_ARCHITECTURE.md)
- [Database Modeling](./docs/08_DATABASE.md)
- [UML Diagrams](./docs/09_UML_DIAGRAMS.md)
- [API Endpoints](./docs/10_API_ENDPOINTS.md)
- [Technical Glossary](./docs/GLOSSARY.md)

## Project Status

| Phase                           | Status                         |
| ------------------------------- | ------------------------------ |
| 1. Planning and Specification   | ✅ Complete (July 27 – Aug 14) |
| 2. Specification and Design     | ✅ Complete (Aug 14 – Aug 25)  |
| 3. Implementation               | 🚧 In Progress                 |
| 4. Testing and Deployment       | ⏳ Scheduled                   |
| 5. Conclusions and Deliverables | ⏳ Scheduled                   |
| 6. Contingency Buffer           | ⏳ Reserved throughout         |

## Getting Started

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

   Serve it with a local server:

   ```bash
   cd web
   python3 -m http.server 3000
   ```

   Then open `http://localhost:3000` in your browser.

### Testing the PWA

After building the Flutter app for web, you can serve the production build and test the PWA installation:

```bash
cd flutter_app
flutter build web
cd build/web
python3 -m http.server 8000
```

Then open `http://localhost:8000` in Chrome and look for the install icon in the address bar.

## Deliveries

| Delivery | Description                  | Week   |
| -------- | ---------------------------- | ------ |
| 1        | Institutional Website        | Aug 24 |
| 2        | Backend with Authentication  | Aug 31 |
| 3        | Free Calculator              | Sep 14 |
| 4        | Map with Overpass API        | Sep 21 |
| 5        | Free Workshops               | Sep 14 |
| 6        | Payments and Premium Content | Oct 12 |
| 7        | Store Publishing             | Oct 19 |

_For a detailed schedule, see the [Gantt Chart](docs/04_GANTT.md)._

## License

MIT License – see [LICENSE](./LICENSE) for details.

---

**Questions or feedback?** Open an issue or reach out via GitHub.
