# Scope Definition – _The Doghouse_

## 1. Introduction

This document establishes the scope of the Minimum Viable Product (_MVP_) for the project _The Doghouse_. This project arises from the need to create a functional digital ecosystem that simultaneously serves as a practical learning ground for emerging technologies and a reusable skeleton for future projects. The _MVP_ consists of a digital platform composed of an institutional website (_landing page_ and _blog_) and a mobile application developed in _Flutter_. The application will be deployed simultaneously to the _Web_ (as a _PWA_ – _Progressive Web App_), _iOS_, and _Android_, sharing the same codebase in its entirety, without duplicating logic or interface. This multiplatform approach is one of the project's central differentiators, demonstrating the versatility and intelligence of _Flutter_ as a development tool.

The project is conducted using a _paper-first_ methodology, where documentation and planning precede implementation, ensuring that all technical and functional decisions are made consciously and documented before any code is written.

## 2. Motivation

The motivation for carrying out this project is threefold.

First, the need to consolidate a robust digital presence for a page with strong social media expression, creating an institutional gathering point (website) and an exclusive area for members (app). This _MVP_ will serve as a functional skeleton that, in the future, will be adapted to the real project.

Second, the desire to learn and master a set of modern technologies and current development practices, namely: _containerization_ with _Docker_, _backend_ development in _Go_, passwordless authentication (_magic links_) and social authentication, integration with payment gateways (_Stripe_) and invoicing systems (_Moloni_), integration with the _Overpass API_, building _Progressive Web Apps_, and, above all, mastering the multiplatform approach with _Flutter_, where a single codebase serves _Web_, _iOS_ and _Android_.

Third, the practical application of good software engineering practices, from requirements specification to deployment in _cloud_ services, including data modeling, _UML_ diagram creation, and end-user testing.

## 3. Objectives

The _MVP_ has the following objectives, according to the _SMART_ methodology:

- **Specific:** Build a functional platform composed of an institutional website (_landing page_ and _blog_) and a _Flutter_ multiplatform application with three areas (calculator, _workshops_, maps), integrating passwordless authentication, payments, and invoicing. The application will be deployed to the _Web_ (as a _PWA_), _iOS_, and _Android_ from the same codebase.
- **Measurable:** The _MVP_ will be complete when a user can: (1) register and authenticate via _magic link_ or social login; (2) navigate the static website and transition to the application without repeating the _login_; (3) access free content; (4) purchase premium content via _Stripe_ (in a _sandbox_ environment); (5) receive a simulated invoice via _Moloni_ (in a _sandbox_ environment); (6) search for hotels through integration with the _Overpass API_ on an interactive map. These flows must work identically on the _Web_, _iOS_, and _Android_.
- **Achievable:** With the chosen stack, an estimated schedule of 8 to 10 weeks, and the use of free and persistent services, the development of the _MVP_ is feasible.
- **Relevant:** The _MVP_ serves as a technical and methodological foundation for real projects, particularly for the social media page with a strong presence, allowing the reuse of the entire architecture and business logic.
- **Time-bound:** The estimated deadline for completing the _MVP_ and its documentation is 10 weeks.

## 4. Proposed Solution

The solution consists of a digital ecosystem with three main components:

### 4.1. Institutional Website (_Landing Page_ + _Blog_)

Developed in pure _HTML_, _CSS_, and _JavaScript_, without _frameworks_, with the goal of optimizing _SEO_ and ensuring fast loading. The _landing page_ presents the project, its benefits, and a call to action for registration. The _blog_ contains static articles about dog care and curiosities, serving as organic content to attract visitors. The _blog_ is accessible to all visitors without authentication, promoting _SEO_ and attracting organic traffic.

### 4.2. _Flutter_ Multiplatform Application (_Web_, _iOS_, _Android_)

The application will be developed in _Flutter_ and compiled for the three platforms from the same codebase, sharing 100% of the business logic, data models, _API_ (_Application Programming Interface_) services, and user interface. This approach ensures complete consistency across platforms and eliminates duplication of effort.

The application will contain three functional areas:

- **Ideal Weight Calculator:** The user selects the dog's breed and enters its age. The free version returns an approximate ideal weight. The premium version returns a complete table with percentiles, growth curves, and dietary recommendations.
- **Workshops Area:** A video library organized by breed. Each breed has a free introductory video and paid videos on specific care, nutrition, training, and health.
- **Maps Area with _Overpass API_ Integration:** An interactive map, implemented in _Flutter_ using a multiplatform package (such as _google_maps_flutter_ or _mapbox_gl_), that displays _pet-friendly_ hotels obtained through integration with the _Overpass API_, with user geolocation (obtained via the _geolocator_ package). Hotels appear as markers on the map. A button will be included to open the selected location in the device's native maps application (e.g., _Google Maps_ or _Apple Maps_), as an additional feature.

On the _Web_, the application will be configured as a _PWA_ (with a _service worker_ and _manifest.json_), allowing direct installation from the browser. In the app stores, the same codebase will be compiled and published on the _App Store_ and _Play Store_, maintaining consistency of functionality and interface across all platforms.

### 4.3. _Backend_ in _Go_ with _REST API_

A _REST_ (_Representational State Transfer_) _API_ developed in _Go_, with the following responsibilities:

- User management (registration, authentication via _magic link_ and social login)
- Content management (breeds, _workshops_, calculator data)
- Integration with _Stripe_ (in a _sandbox_ environment) for payment processing
- Integration with _Moloni_ (in a _sandbox_ environment) for invoicing
- Integration with the _Overpass API_ to obtain _pet-friendly_ hotel data
- Email sending service for _magic links_

## 5. Functional Scope

### 5.1. Included Features

**Institutional Website:**

- Institutional _landing page_
- Static _blog_ with articles (accessible without _login_)

**Authentication:**

- User registration with email
- Authentication via _magic link_ (link sent by email)
- Authentication via social networks (_Google_ and/or _Facebook_)
- _Seamless_ transition between the static website and the _Flutter_ application (session sharing)

**Application – Calculator:**

- Ideal weight calculator (basic free version)
- Ideal weight calculator (complete premium version)

**Application – Workshops:**

- _Workshops_ area with free videos
- _Workshops_ area with paid videos

**Application – Maps:**

- Interactive map with _pet-friendly_ hotels obtained through integration with the _Overpass API_
- User geolocation to display nearby results
- Button to open location in the device's native maps application

**Payments and Invoicing:**

- Checkout via _Stripe_ (in a _sandbox_ environment) for purchasing premium content
- Invoice issuance via _Moloni_ (in a _sandbox_ environment)

**Deployment:**

- Deployment of the _Flutter_ application to the _Web_ (with _PWA_), _iOS_, and _Android_, sharing the same codebase
- Publication of the application on the _App Store_ and _Play Store_ with the same code version

### 5.2. Excluded Features

- Administration panel for content management (data is inserted directly into the database or files)
- _Blog_ comment system
- Social features (shares, likes, comments)

## 6. Technical Scope

### 6.1. Technology Stack

- **Backend:** _Go_ (learning from scratch)
- **Frontend (website):** Pure _HTML_, _CSS_, _JavaScript_
- **Frontend (application):** _Flutter_, compiled for the _Web_ (as a _PWA_), _iOS_, and _Android_ from the same codebase
- **Database:** _PostgreSQL_
- **Containerization:** _Docker_ (learning from scratch)
- **Authentication:** _Magic links_ (sent by email) + Social login (_Google_/_Facebook_) (learning from scratch)
- **Payments:** _Stripe_ (in a _sandbox_ environment) (learning from scratch)
- **Invoicing:** _Moloni_ (in a _sandbox_ environment) (learning from scratch)
- **Maps:** Use of the _google_maps_flutter_ package (or _mapbox_gl_) to render the map consistently across the three platforms. Geolocation will be obtained using the _geolocator_ package. Hotels obtained through integration with the _Overpass API_ will be displayed as markers on the map. A button will be included to open the location in the device's native maps application, as an additional feature (learning from scratch).
- **_Overpass API_ Integration:** _Go_ (_HTTP_ client for queries to the public _API_) (learning from scratch)
- **Geocoding:** Use of the _Nominatim_ service (_OpenStreetMap_) to convert text addresses into geographic coordinates, allowing the user to search for hotels by textual location on the map (e.g., searching for "Porto" and centering the map on that location) (learning from scratch).

### 6.2. External Services and Deployment

For the deployment and operation of the _MVP_, the following external services will be used, all with free plans adequate to the project's scope:

- **Repository:** _GitHub_ (public)
- **Containerization:** _Docker_ (for development and consistency across environments)
- **Database:** _Neon_ ([neon.tech](https://neon.tech/)) will be used, a free _PostgreSQL_ service with 500 MB of storage, without the need for periodic renewal. _Neon_ offers _branches_ for development, _point-in-time recovery_, and a modern interface, making it a robust choice for the _MVP_.
- **Backend (_Go_):** Deployment on a service that supports _Docker_ containers, such as _Render_, _[Fly.io](https://fly.io/)_, or _Railway_. Although some of these services have _cold starts_ after periods of inactivity, choosing one of them allows the project to run continuously without costs.
- **Frontend (_HTML_ website):** Deployment on _Vercel_ or _Netlify_ (free)
- **Flutter Web Application (_PWA_):** Deployment on _Vercel_ or _Netlify_ (free, with support for _service workers_ for the _PWA_)
- **Flutter iOS Application:** Build and publication on the _App Store_ (_Apple developer_ account)
- **Flutter Android Application:** Build and publication on the _Play Store_ (_Google developer_ account)
- **Emails for _Magic Links_:** Transactional email service (e.g., _SendGrid_, _Mailgun_, or _Resend_ - all with free plans)
- **Stripe:** Free _Stripe_ account with an active _sandbox_ environment
- **Moloni:** Free _Moloni_ account with an active _sandbox_ environment. **Note about _Moloni_:** Within the scope of the _MVP_, the integration with _Moloni_ will be carried out in a _sandbox_ environment, without real tax effects. The generated invoices are simulated and serve only to demonstrate the invoicing flow. In the future, migration to production will require setting up a commercial account, with a company tax ID and contract with _Moloni_, to issue legally valid tax documents.
- **Domain:** No custom domain will be purchased. The free subdomains provided by the deployment platforms will be used. The final architecture will be as follows:
  - Institutional website (_HTML_/_CSS_/_JS_): `site.thedoghouse.netlify.app` or `site.thedoghouse.vercel.app`
  - Flutter Web Application (_PWA_): `app.thedoghouse.netlify.app` or `app.thedoghouse.vercel.app`
  - Backend _API_ (_Go_): `api.thedoghouse.onrender.com` or `api.thedoghouse.fly.dev`
  - _PostgreSQL_ Database: _Neon_ service ([neon.tech](https://neon.tech/))  
    The separation into distinct subdomains allows sharing _cookies_/_tokens_ for a _seamless_ transition between the website and the application, keeping the session active.

### 6.3. Deployment Strategy

The deployment strategy is incremental, with successive deliveries of autonomous features, allowing early validation in production. The services will be distributed as follows:

- **Frontend (website and _Flutter_ Web):** _Vercel_ or _Netlify_ (optimized for static _frontend_ and _PWA_)
- **Backend (_API_ in _Go_):** _Render_, _[Fly.io](https://fly.io/)_, or _Railway_ (support for _Docker_ containers)
- **Database:** _Neon_ (free and persistent _PostgreSQL_, without periodic renewals)

This separation ensures that each service is hosted on the most appropriate platform, maximizing performance and minimizing costs.

The session will be maintained through a _JWT_ token stored in _localStorage_, with a root domain allowing access between subdomains (`.thedoghouse.netlify.app` and `.thedoghouse.onrender.com`).

The delivery sequence is as follows:

- **Delivery 1 – Institutional Website:** Deployment of the _landing page_ and _blog_ in _HTML_, _CSS_, and _JavaScript_ on _Vercel_ or _Netlify_.
- **Delivery 2 – Base Backend with Authentication:** Deployment of the _API_ in _Go_ on a container service (_Render_, _[Fly.io](https://fly.io/)_, or _Railway_) with the active _PostgreSQL_ database (_Neon_). Deployment of the _Flutter_ application with _login_ and profile interface, still without features.
- **Delivery 3 – Free Calculator:** Integration of the basic calculator into the _Flutter_ application, available to all authenticated users.
- **Delivery 4 – Map with _Overpass API_ Integration:** Addition of the maps area with _Overpass API_, geolocation, and dynamic _viewport_. Universal feature for authenticated users.
- **Delivery 5 – Free _Workshops_:** Availability of free introductory videos organized by breed.
- **Delivery 6 – Payments and Premium Content:** Implementation of _Stripe_ (payments) and _Moloni_ (invoicing), with complete calculator, paid _workshops_ (_bundles_), and conditional access logic.
- **Delivery 7 – Store Publication:** Submission of the _Flutter_ application to the _App Store_ and _Play Store_.

Each delivery is preceded by development tests and followed by production tests, ensuring system stability.

The technical strategy also includes:

- Use of _Docker_ to ensure consistency between development and production environments
- Separation of free subdomains for the static website and the _Flutter_ Web application, allowing _cookie_/_token_ sharing for _seamless_ transition
- Use of _HTTPS_ on all services (guaranteed by the deployment platforms)
- Configuration of environment variables for _API_ keys and sensitive configurations
- The database hosted on a persistent service (_Neon_), decoupled from the _backend_, so that even if the _backend_ container is restarted or experiences a _cold start_, the data remains intact
- The _Flutter_ application compiled separately for each platform, maintaining the same codebase and using native tools for each _build_ (_flutter build web_, _flutter build ios_, _flutter build apk_)
- Each delivery is deployed independently, allowing the website, _backend_, and application to be updated without affecting the other components

### 6.4. Critical Technical Decisions

The following technical decisions were made to guide development and ensure project coherence:

- **Hotel data source:** The _Overpass API_ (_OpenStreetMap_) will be used as the sole source of geospatial data for the maps area, with the tags `dog=yes` or `pets=yes` for filtering _pet-friendly_ hotels. This approach is more stable and legally risk-free compared to direct _web scraping_ of commercial websites. For text-based search, the _Nominatim_ service will be used for geocoding, allowing the user to search for hotels by locality name.
- **Deployment strategy:** The website and _Flutter_ Web application will be hosted on _Vercel_ or _Netlify_, the _Go_ backend on container services (_Render_, _[Fly.io](https://fly.io/)_, or _Railway_), and the _PostgreSQL_ database on _Neon_. The subdomains will be `site.*`, `app.*`, and `api.*`.
- **Moloni:** Integration will be carried out in a _sandbox_ environment, without real tax effects, with the possibility of migrating to production in the future.
- **Authentication:** The system only supports _magic links_ and social login, excluding the traditional email and password method.
- **Environment Variables:** The configuration will include the following variables: `STRIPE_API_KEY`, `MOLONI_API_KEY`, `DATABASE_URL`, `SENDGRID_API_KEY`, `GOOGLE_OAUTH_ID`, `FACEBOOK_OAUTH_ID`, `OVERPASS_API_ENDPOINT`.

## 7. Technologies to Learn

This project is deliberately oriented towards the practical learning of the following technologies:

- _Docker_ – containerization of the development and production environment
- _Go_ – _backend_ development, from the _REST API_ to integration with external _APIs_
- _Magic Links_ – implementation of passwordless authentication
- _Social Login_ – integration with _OAuth_ providers (_Google_/_Facebook_)
- _Stripe_ (in _sandbox_) – payment processing, _webhooks_, and purchase management
- _Moloni_ (in _sandbox_) – invoicing and integration with invoicing systems
- _Overpass API_ – integration with a public _API_ to obtain geospatial data on _pet-friendly_ hotels
- _PWA_ – configuration of _service workers_, _manifest.json_, and browser installation
- _Flutter_ Multiplatform – structuring code to support _Web_, _iOS_, and _Android_ with the same base, compiling and publishing for all three platforms
- Maps in _Flutter_ with _google_maps_flutter_ or _mapbox_gl_ and geolocation with _geolocator_
- _Seamless_ Transition – session sharing between distinct applications (_HTML_ + _Flutter_) on free subdomains
- Store Publishing – submission and publication process on the _App Store_ and _Play Store_

**Note on publishing:** Publishing on the stores requires the generation of signing keys (_iOS certificates_, _Android keystore_), the process of which will be detailed in the Work Breakdown Structure.

## 8. Conclusion

The _The Doghouse_ _MVP_ represents an ambitious but well-defined project, reconciling the creation of a functional product with the structured learning of current and relevant technologies. The scope defined in this document serves as a base contract that will guide all subsequent phases of the project, from technical specification to deployment and validation.

The decision to deploy the _Flutter_ application to the _Web_, _iOS_, and _Android_ from the same codebase is one of the central differentiators of this _MVP_. This approach not only demonstrates the versatility of _Flutter_ as a development tool but also ensures that the project is prepared for the real market, where presence on multiple platforms is essential.

Conscious decisions were made regarding deployment services, opting for free and persistent solutions for the database (with _Neon_), avoiding periodic renewals, and using free subdomains instead of custom domains. The application will be published on the official stores, using free developer accounts or those with minimal associated costs.

Meeting this scope will ensure that the _MVP_ is completed within the estimated timeframe, that all target technologies are explored practically, and that the resulting skeleton is robust, reusable, and truly multiplatform, ready for the real project of the social media page.
