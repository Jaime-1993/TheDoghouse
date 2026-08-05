# Work Breakdown Structure (WBS) – _The Doghouse_

**General Note:** Each implementation activity must include a self-review and verification against specifications before deployment.

## 1. Planning and Specification

1.1. Scope Definition – 8h

1.2. User Personas and Flows Identification – 10h

1.3. WBS Elaboration – 6h

1.4. Initial Gantt Elaboration – 4h

_Milestone: Initial proposal delivery_

---

## 2. Specification, Design, and Implementation Start

2.1. Research and analysis of similar solutions – 6h

2.2. Functional and non-functional requirements specification – 12h

2.3. General architecture design – 10h

 2.3.1. Backend architecture definition in Go – 3h

 2.3.2. Frontend architecture definition (HTML website and Flutter application) – 3h

 2.3.3. Containerization strategy definition with Docker – 2h

 2.3.4. Session sharing strategy definition between website and application – 2h

2.4. Database modeling – 10h

2.5. UML diagrams elaboration – 8h

 2.5.1. Class diagram – 4h

 2.5.2. Sequence diagrams (critical flows) – 4h

2.6. API (Application Programming Interface) endpoints definition and interaction flows – 10h

2.7. Development environment setup – 4h

 2.7.1. GitHub repository creation – 1h

 2.7.2. Initial Docker Compose configuration (database, backend, proxy) – 2h

 2.7.3. Project folder structure definition – 1h

2.8. Base structure implementation start – 6h

 2.8.1. Hello World implementation in Go backend – 2h

 2.8.2. Institutional website skeleton creation (HTML/CSS/JS) – 2h

 2.8.3. Flutter application skeleton creation (Web, iOS, and Android configuration) – 1h

 2.8.4. manifest.json and service worker configuration for PWA (Progressive Web App) – 1h

2.9. Use case diagram elaboration (PlantUML) – 3h

_Milestone: Architecture and specifications validation_

_Milestone: Interim report delivery_

---

## 3. Complete MVP Implementation (Incremental Deliveries)

**Note on source code documentation:** Each delivery must include internal documentation (comments, docstrings, technical README) as an integral part of development, ensuring code maintainability.

### 3.1. Delivery 1 – Institutional Website

_Dependencies: None (can be the first)_

3.1.1. Landing page HTML structure – 4h

3.1.2. CSS styling and responsiveness – 4h

3.1.3. Static blog content – 3h

3.1.4. SEO (Search Engine Optimization) optimization (meta tags, JSON-LD, HTML semantics) – 3h

3.1.5. Website unit tests – 2h

3.1.6. Website deployment on Vercel or Netlify – 2h

_Milestone: Delivery 1 available online_

---

### 3.2. Delivery 2 – Base Backend with Authentication

_Dependencies: Can be parallel to Delivery 1 (but authentication is the base for the following ones)_

3.2.1. Data model and ORM (Object-Relational Mapping) implementation (database connection) – 6h

3.2.2. Authentication service implementation (magic link and social login) – 10h

3.2.3. Email sending service implementation for magic links – 4h

3.2.4. Authentication interface implementation in Flutter application (registration and login) – 6h

3.2.5. Cookie/token sharing configuration between HTML website and Flutter application – 4h

3.2.6. Redirect implementation with active session (seamless transition) – 3h

3.2.7. Authentication unit tests – 4h

3.2.8. Backend deployment in Go (in Docker container on Render, Fly.io, or Railway) – 3h

3.2.9. Database deployment on persistent service (Neon) – 2h

3.2.10. Flutter application deployment with login and profile interface (still without features) – 2h

3.2.11. Environment variables and HTTPS (Hypertext Transfer Protocol Secure) configuration – 2h

_Milestone: Delivery 2 available online (functional authentication)_

---

### 3.3. Delivery 3 – Free Calculator

_Dependencies: Delivery 2 (backend and authentication)_

3.3.1. Content service implementation in backend (breeds and calculator data) – 6h

3.3.2. Calculator implementation (basic version) in Flutter application – 8h

3.3.3. Calculator integration with backend API – 4h

3.3.4. Calculator unit tests – 3h

3.3.5. Calculator flow tests in development environment – 2h

3.3.6. Flutter application update deployment (with functional calculator) – 2h

_Milestone: Delivery 3 available online (functional free calculator)_

---

### 3.4. Delivery 4 – Map with Overpass API and Geolocation

_Dependencies: Delivery 2 (backend and authentication) – can be parallel to Delivery 3_

3.4.1. Overpass API integration module implementation for pet-friendly hotels – 10h

3.4.1a. Nominatim integration implementation for geocoding (converting text location into geographic coordinates) – 3h

3.4.2. Cache logic implementation for map results (with TTL – Time To Live of 24 hours) – 4h

3.4.3. Map area implementation in Flutter application (geolocation, dynamic viewport, backend and Overpass API integration) – 12h

3.4.4. Map integration with backend API – 4h

3.4.5. Map and cache unit tests – 4h

3.4.6. Hotel search flow tests on map (dynamic viewport and cache) – 3h

3.4.7. Backend and Flutter application update deployment (with functional map) – 2h

_Milestone: Delivery 4 available online (functional map with real data)_

---

### 3.5. Delivery 5 – Free Workshops

_Dependencies: Delivery 2 (backend and authentication) – can be parallel to Deliveries 3 and 4_

3.5.1. Content service implementation in backend (introductory videos) – 6h

3.5.2. Workshops area implementation in Flutter application (breeds list and introductory videos) – 8h

3.5.3. Workshops integration with backend API – 4h

3.5.4. Workshops unit tests – 3h

3.5.5. Free workshops flow tests – 2h

3.5.6. Flutter application update deployment (with free workshops) – 2h

_Milestone: Delivery 5 available online (functional free workshops)_

---

### 3.6. Delivery 6 – Payments and Premium Content

_Dependencies: Deliveries 3, 4, and 5 (base content to become premium)_

3.6.1. Payments module implementation (Stripe in sandbox) – 10h

3.6.2. Stripe webhooks implementation in backend (with retry logic) and polling in Flutter application to check purchase status – 6h

3.6.3. Invoicing module implementation (Moloni in sandbox) – 6h

3.6.4. Stripe account configuration in sandbox mode – 2h

3.6.5. Moloni account configuration in sandbox mode (with logo and invoice template) – 2h

3.6.6. Calculator implementation (complete premium version) in Flutter application – 6h

3.6.7. Paid workshops implementation in Flutter application (individual purchase, breed bundle, complete present bundle, lifetime bundle) – 10h

3.6.8. Conditional access logic implementation (purchased vs. locked) – 6h

3.6.9. Profile area and invoice viewing implementation – 4h

3.6.10. Payments and invoices unit tests – 4h

3.6.11. Purchase flow tests (Stripe webhook and content unlocking) – 4h

3.6.12. Invoice issuance flow tests (Moloni) – 3h

3.6.13. Complete purchase flow integration tests (Stripe → Webhook → Moloni → unlocking in Flutter application) – 4h

3.6.14. Access upgrade flow tests (e.g., individual video → breed bundle) – 3h

3.6.15. Backend and Flutter application update deployment (with premium content and payments) – 2h

_Milestone: Delivery 6 available online (complete ecosystem with monetization)_

---

### 3.7. Delivery 7 – Store Publishing

_Dependencies: Delivery 6 (complete app)_

3.7.1. Final Flutter application configuration for iOS (certificates, profiles, build) – 8h

3.7.2. Final Flutter application configuration for Android (signing key, build) – 4h

3.7.3. Application submission to the App Store (Apple developer account) – 4h

3.7.4. Application submission to the Play Store (Google developer account) – 4h

3.7.5. Tests on real devices after publishing – 4h

_Milestone: Delivery 7 available (application published on stores)_

---

### 3.8. Cross-Cutting Source Code Documentation

_Continuous activity throughout all deliveries_

3.8.1. Comments and docstrings in Go – 4h

3.8.2. Comments and docstrings in Flutter – 4h

3.8.3. Technical repository README – 3h

---

## 4. Testing, Validation, and Deployment

4.1. Functional tests – 16h

 4.1.1. Manual tests of complete flows in development environment – 4h

 4.1.2. Usability and user experience tests – 3h

 4.1.3. Performance and response time tests (map with many hotels, database queries, cache hit/miss) – 5h

 4.1.4. Flutter cross-platform compatibility tests (consistency verification between Web PWA, iOS, and Android) – 4h

4.2. Final deployment and adjustments – 8h

 4.2.1. Subdomain configuration for website and application – 2h

 4.2.2. HTTPS verification on all services – 1h

 4.2.3. Cookie/token sharing verification for seamless transition – 2h

 4.2.4. PWA optimization for loading times – 3h

4.3. End-user tests – 6h

 4.3.1. Testers group selection (3 to 5 users) – 1h

 4.3.2. User experience feedback collection – 3h

 4.3.3. Bugs and improvement suggestions registration – 2h

4.4. Final adjustments based on feedback – 8h

 4.4.1. Reported bugs correction – 4h

 4.4.2. Usability and interface improvements – 3h

 4.4.3. Final deployment with adjustments – 1h

4.5. Security tests – 8h

 4.5.1. Input validation and injection protection (SQL, XSS) – 3h

 4.5.2. Authentication and authorization tests (JWT, rate limiting for magic links) – 3h

 4.5.3. CORS and security headers configuration – 2h

4.6. Production Monitoring and Logging Configuration – 6h

 4.6.1. Sentry or similar integration for error tracking – 2h

 4.6.2. Centralized logging configuration in backend (Go) – 2h

 4.6.3. Alerts configuration for critical failures – 2h

4.7. Rollback and Disaster Recovery Procedure – 3h

 4.7.1. Rollback plan documentation for backend – 1.5h

 4.7.2. Rollback plan documentation for Flutter – 1.5h

_Milestone: Beta Launch (available online – all deliveries complete)_

---

## 5. Conclusions and Final Report

5.1. Final report consolidation – 12h

 5.1.1. Executive project summary – 2h

 5.1.2. Comparison between planned and executed – 3h

 5.1.3. Technical challenges encountered and solutions adopted – 4h

 5.1.4. Lessons learned on each technology (Docker, Go, Stripe, Moloni, Flutter multiplatform, PWA, Overpass API) – 3h

5.2. Final review and formatting – 6h

 5.2.1. Orthographic and style review of all documentation – 3h

 5.2.2. Final document formatting for delivery – 3h

5.3. Article preparation for The Pharmacist, but tech – 8h

 5.3.1. Article writing about the paper-first methodology – 4h

 5.3.2. Screenshots and diagrams inclusion – 2h

 5.3.3. Article publication – 2h

5.4. Technical glossary elaboration – 4h

_Milestone: Final report delivery and article publication_

---

## 6. Contingency and Final Adjustments

6.1. Contingency buffer (15% of total estimated) – 60h

6.2. Unforeseen final adjustments – 10h

---

## Delivery Dependencies Legend

- **Delivery 1** – No dependencies (can be first)
- **Delivery 2** – No external dependencies (can be parallel to Delivery 1)
- **Delivery 3** – Depends on Delivery 2 (backend and authentication)
- **Delivery 4** – Depends on Delivery 2 (backend and authentication) – can be parallel to Delivery 3
- **Delivery 5** – Depends on Delivery 2 (backend and authentication) – can be parallel to Deliveries 3 and 4
- **Delivery 6** – Depends on Deliveries 3, 4, and 5 (base content to become premium)
- **Delivery 7** – Depends on Delivery 6 (complete application)
