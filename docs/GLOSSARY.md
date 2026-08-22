# Technical Glossary – _The Doghouse_

## Introduction

This glossary aims to define the technical terms used throughout the documentation of the _The Doghouse_ project. The definitions are contextualized for the project's scope, ensuring that all readers, regardless of their familiarity with the technologies involved, can understand the concepts presented.

This glossary will be updated whenever new technical terms are introduced in the project documents.

## List of Terms

**Access Resolution Logic**  
Algorithm implemented in the _backend_ to verify whether a user has access to a specific content. The verification follows four sequential steps: direct purchase with `status = 'completed'`; content included in an acquired _bundle_; purchase of `calculator_premium_access`; or a _bundle_ with `includes_premium_calculator = true`. If none of the conditions are met, access is denied. In the project, this logic is described in section 2.6 of [08_DATABASE.md](08_DATABASE.md) and implemented in the content _API endpoints_.

**API** (_Application Programming Interface_)  
A set of rules and protocols that enables communication between software systems. In the project, the _REST API_ developed in _Go_ serves as the connection point between the _frontend_ (institutional website and _Flutter_ application) and the database, enabling data exchange.

**API Endpoint**  
A specific _URL_ through which an _API_ can be accessed. Each _endpoint_ corresponds to a system feature or resource. In the project, the _REST API endpoints_ are documented in [10_API_ENDPOINTS.md](10_API_ENDPOINTS.md) and organized by functional module, such as authentication, content, maps, payments, and profile.

**Bearer Token**  
An _HTTP_ authentication mechanism where a _token_ (usually JWT) is sent in the _Authorization_ header to prove the user's identity. In the project, the _Bearer Token_ is used to authenticate requests to the _API_, sent in the format `Authorization: Bearer <jwt_token>`.

**Bundle**  
A package of content or features sold as a set at a special price. In the project, paid _workshops_ can be purchased in _bundles_ (by breed, complete present, or lifetime), offering flexibility and added value to the user.

**CI/CD** (_Continuous Integration / Continuous Deployment_)  
A software development practice that automates code integration and application _deployment_. In the project, _CI/CD_ is planned to automate the _deploys_ of the _Go_ _backend_, the institutional website, and the _Flutter_ application whenever changes are made to the _GitHub_ repository.

**Cold Start**  
Initial delay in starting an application after a period of inactivity, common in _cloud_ services that suspend inactive containers to save resources. In the project, the _Go_ _backend_, hosted on services like _Render_ or _Fly.io_, may experience _cold starts_, which is acceptable for an _MVP_ without critical latency requirements.

**Complete Present Bundle**  
A _bundle_ that includes all workshop videos of all breeds existing at the time of purchase. In the project, this _bundle_ also includes access to the premium calculator, being one of three ways to obtain that access.

**Containerization**  
A virtualization technique that allows packaging an application and all its dependencies into an isolated container, ensuring consistency between development and production environments. In the project, _Docker_ is used to _containerize_ the _Go_ _backend_, the _PostgreSQL_ database, and the _proxy_, facilitating _deployment_ and reproducibility.

**CORS** (_Cross‑Origin Resource Sharing_)  
A security mechanism that controls how resources from one domain are accessed by applications from other domains. In the project, _CORS_ is configured in the _Go_ _backend_ to allow the institutional website and the _Flutter_ application to make secure requests to the _API_.

**CRUD** (_Create, Read, Update, Delete_)  
An acronym for the four basic data manipulation operations in information systems. In the project, _CRUD_ operations are used to manage users, breeds, _workshops_, and other content in the database.

**Disaster Recovery**  
A plan and process for recovering an application after critical failures, ensuring service continuity. In the project, _Disaster Recovery_ covers backup and database restoration procedures, as well as _deployment_ rollbacks.

**Docker**  
A _containerization_ platform that allows packaging applications and their dependencies into isolated containers. In the project, _Docker_ is used to _containerize_ the _Go_ _backend_, the _PostgreSQL_ database, and the _proxy_, ensuring consistency between development and production environments.

**Docstring**  
Structured comments within functions and classes that describe their purpose, parameters, and return values. In the project, _docstrings_ in _Go_ and _Flutter_ ensure that the code is self‑documenting and easy to maintain.

**Flutter**  
An open‑source _framework_ by _Google_ for developing multiplatform applications (Web, iOS, Android) from a single codebase. In the project, _Flutter_ is the core technology of the application, compiled for the _Web_ (as a _PWA_), _iOS_, and _Android_, sharing 100% of the business logic and interface.

**Fly.io**  
A _deployment_ platform for containerized applications, with free plans suitable for prototypes. In the project, _Fly.io_ is one of the options considered for hosting the _Go_ _backend_, as an alternative to _Render_ or _Railway_.

**Freemium**  
A business model that offers a free version with limited features and a paid version with advanced features. In the project, the _freemium_ model is applied to the calculator (basic free version vs. complete premium version) and to the _workshops_ (free introductory videos vs. paid videos), where premium access is acquired through one‑time purchase, breed _bundle_, _Complete Present Bundle_, or _Lifetime Bundle_.

**Gantt**  
A type of bar chart used to represent a project's schedule, showing task duration and sequence. In the project, the _Gantt_ chart is documented in [04_GANTT.md](04_GANTT.md) and presents the timeline of _MVP_ deliveries and milestones.

**Geolocator**  
A _Flutter_ package used to obtain the device's geographic location (latitude and longitude coordinates) with the user's consent. In the project, the _geolocator_ is used to center the map on the user's location in the Near Me feature.

**Git / GitHub**  
A distributed version control system and hosting platform. In the project, the public _GitHub_ repository stores all source code, facilitating versioning and collaboration.

**Go**  
A compiled, statically typed programming language developed by _Google_. In the project, _Go_ is used to develop the _REST API_ _backend_, being one of the core technologies of the _MVP_.

**Hash / SHA‑256**  
A function that transforms input data into a fixed‑size value (digest) in a one‑way manner. _SHA‑256_ is one of the most common _hash_ functions. In the project, _SHA‑256_ is used to compute the _hash_ of _magic link_ _tokens_, ensuring that _tokens_ are never stored in plain text in the database.

**HTTP / HTTPS** (_Hypertext Transfer Protocol / Hypertext Transfer Protocol Secure_)  
Communication protocols used to transfer data on the _web_. _HTTPS_ is the secure version, with _TLS_/_SSL_ encryption. In the project, all communications between the _frontend_ and the _backend_ use _HTTPS_ in the production environment.

**JSON** (_JavaScript Object Notation_)  
A lightweight data interchange format, based on text, easy for humans to read and write and easy for machines to parse and generate. In the project, _JSON_ is the standard format for messages exchanged between the _frontend_ and the _REST API_.

**JSON‑LD** (_JSON for Linking Data_)  
A format for structuring data in _JSON_ with well‑defined semantics, primarily used in _SEO_. In the project, _JSON‑LD_ is used to describe data structure (e.g., _blog_ articles) to search engines.

**JWT** (_JSON Web Token_)  
An open standard for securely representing _claims_ between two parties. In the project, the _JWT_ is used to maintain the authenticated user's session, stored in _localStorage_ and shared between the institutional website and the _Flutter_ application for _seamless_ transition. The _token_ is valid for 7 days and is renewable.

**JWT Claim**  
Information contained within a JWT _token_, represented as a name/value pair. _Claims_ may include the user identifier, expiration date, and other relevant information for authentication and authorization.

**Lifetime Bundle**  
A _bundle_ that includes all existing and future workshop videos, guaranteeing lifetime access to new content as it is added. In the project, this _bundle_ also includes access to the premium calculator, being one of three ways to obtain that access.

**localStorage**  
A browser storage mechanism, persistent across sessions. In the project, _localStorage_ is used to store the JWT _token_ of the authenticated user, enabling the _seamless_ transition between the institutional website and the _Flutter_ application.

**Logging**  
The process of recording events and activities of an application in files or centralized services. In the project, centralized _logging_ in the _Go_ _backend_ allows tracking requests, errors, and critical events for debugging and analysis.

**Magic Link**  
An authentication _link_ sent by email that allows the user to log in without providing a password. In the project, the _magic link_ is one of two supported authentication methods, with a 15‑minute validity period and single use.

**Mock**  
A simulated object or data that mimics the behavior of a real component for testing purposes. In the project, calculator data, hotels, and workshop videos are _mocks_ to demonstrate system flow without relying on real data. _Stripe_ and _Moloni_ are used in _sandbox_ mode, which acts as a _mock_ for payments and invoicing.

**Moloni**  
A Portuguese invoicing system with _sandbox_ environment support. In the project, _Moloni_ is integrated to generate simulated invoices in _PDF_ after each successful purchase, demonstrating the invoicing flow without real tax effects.

**MVP** (_Minimum Viable Product_)  
A version of a product with sufficient features to be used by early users, allowing validation of the value proposition and collection of feedback. In the project, _The Doghouse_ is an _MVP_ that serves as a learning ground and reusable skeleton for future projects.

**Neon**  
A free _PostgreSQL_ service with 500 MB of storage, without the need for periodic renewal. In the project, _Neon_ is the chosen database for the _MVP_, offering _branches_ for development and _point‑in‑time recovery_.

**Nominatim**  
A free geocoding service based on _OpenStreetMap_ data that converts addresses and place names into geographic coordinates (latitude and longitude). In the project, _Nominatim_ allows users to search for hotels by locality name (e.g., "Porto") in the maps area, rather than only requesting location.

**OAuth** (_Open Authorization_)  
An open authorization protocol that allows users to authenticate through third parties (e.g., _Google_, _Facebook_) without sharing passwords. In the project, _OAuth_ is used to implement social _login_, allowing users to register or authenticate through _Google_ or _Facebook_.

**ORM** (_Object‑Relational Mapping_)  
A technique that maps objects from a programming language to tables in a relational database. In the project, the _ORM_ is used in the _Go_ _backend_ to simplify interaction with the _PostgreSQL_ database, abstracting the programmer from writing manual _SQL_ queries.

**Overpass API**  
A public _API_ that allows querying _OpenStreetMap_ geospatial data in a structured way. In the project, the _Overpass API_ is the primary data source for obtaining _pet‑friendly_ hotels based on location, using the tags `dog=yes` or `pets=yes`.

**Paper‑first**  
A methodology where documentation and planning precede implementation. In the project, the _paper‑first_ approach ensures that all technical and functional decisions are made consciously and documented before any code is written, as described in [01_SCOPE.md](01_SCOPE.md).

**PlantUML**  
An open‑source tool that allows creating _UML_ diagrams from a textual description language. In the project, _PlantUML_ is used to generate the class diagram and sequence diagrams documented in [09_UML_DIAGRAMS.md](09_UML_DIAGRAMS.md).

**Polling**  
A communication technique where a client periodically checks a server for new data or updates. In the project, the _Flutter_ application implements _polling_ to check if a _Stripe_ payment _webhook_ has been processed, allowing premium content to be unlocked even if the _webhook_ is delayed.

**PostgreSQL**  
An open‑source relational database management system, known for its robustness and _JSON_ support. In the project, _PostgreSQL_ is the chosen database, hosted on _Neon_, to store all system entities.

**Postman**  
A tool used to test and document _APIs_, allowing _HTTP_ requests to be sent and responses to be analyzed. In the project, _Postman_ is used to test the _REST API_ _endpoints_ during the development phase.

**Premium**  
A designation for paid content or features, accessed through one‑time purchase. In the project, _premium_ access is granted per specific content (complete calculator, paid _workshops_) and there is no global _premium_ status, in accordance with the conditional access business rule.

**PWA** (_Progressive Web App_)  
A _web_ application that uses modern technologies to offer an experience similar to a native application. In the project, the _Flutter_ application is configured as a _PWA_, allowing direct installation from the browser without the need for app stores.

**Railway**  
A _deployment_ platform for containerized applications, with free plans suitable for prototypes. In the project, _Railway_ is one of the options considered for hosting the _Go_ _backend_, as an alternative to _Render_ or _Fly.io_.

**Rate Limiting**  
An access control technique that limits the number of requests from a client in a specific time period. In the project, _rate limiting_ is implemented in authentication to prevent brute‑force attacks, limiting _magic link_ requests to 5 per hour per email address.

**Render**  
A _deployment_ platform for containerized applications, with free plans suitable for prototypes. In the project, _Render_ is one of the options considered for hosting the _Go_ _backend_, as an alternative to _Fly.io_ or _Railway_.

**REST** (_Representational State Transfer_)  
An architectural style for _APIs_ that uses _HTTP_ as the communication protocol, with well‑defined operations (_GET_, _POST_, _PUT_, _DELETE_) and responses in formats such as _JSON_. In the project, the _REST API_ in _Go_ is the standardized interface for all system operations.

**Retry Logic**  
A mechanism that automatically attempts to repeat a failed operation multiple times with increasing intervals. In the project, _Stripe_ implements automatic _retry_ for undelivered _webhooks_, ensuring that payment notifications reach the _backend_.

**Rollback**  
The process of reverting an update or _deployment_ to a previous version in case of failure or issues. In the project, _rollback_ is documented for the _Go_ _backend_ and the _Flutter_ application, allowing quick reversion to a stable version if a _deploy_ introduces _bugs_.

**Sandbox**  
An isolated testing environment that simulates a production environment without affecting real data or production systems. In the project, _Stripe_ and _Moloni_ are used in _sandbox_ mode, allowing payment and invoice simulations without real tax effects.

**Seamless** (_continuous transition_)  
A fluid and continuous navigation experience between different parts of a system, without noticeable interruptions. In the project, the _seamless_ transition between the institutional website and the _Flutter_ application allows the authenticated user to navigate between both without repeating the _login_.

**SendGrid**  
A transactional email service with free plans. In the project, _SendGrid_ (or _Mailgun_ or _Resend_) is used to send emails with _magic links_, purchase confirmations, and welcome messages.

**Sentry**  
A real‑time error tracking platform that captures and reports exceptions and errors in applications. In the project, _Sentry_ is integrated into the _Go_ _backend_ to monitor production failures.

**SEO** (_Search Engine Optimization_)  
A set of practices to improve a website's visibility in search engines. In the project, the _blog_ and _landing page_ use technical _SEO_ (meta tags, _JSON‑LD_, _HTML_ semantics) to attract organic traffic.

**Service Worker**  
A _JavaScript_ script that runs in the background of the browser, enabling _offline_ features and resource caching. In the project, the _service worker_ is configured in the _PWA_ to allow _offline_ access to the application and installation as a browser app.

**SMART** (_Specific, Measurable, Achievable, Relevant, Time‑bound_)  
A methodology for defining clear and measurable objectives. In the project, the _MVP_ objectives are defined according to _SMART_ criteria, as described in [01_SCOPE.md](01_SCOPE.md).

**SQL** (_Structured Query Language_)  
A standard language for querying and manipulating relational databases. In the project, _SQL_ is used to interact with the _PostgreSQL_ database, through parameterized _queries_ or an _ORM_.

**Stripe**  
A payment gateway with _sandbox_ environment support. In the project, _Stripe_ is integrated to process payments for premium content, with _webhooks_ for transaction confirmation and automatic _retry_ logic.

**TTL** (_Time To Live_)  
The period during which data is considered valid and stored in _cache_ before being considered obsolete. In the project, data obtained via the _Overpass API_ is stored in _cache_ with a _TTL_ of 24 hours, avoiding excessive queries to the external _API_.

**UML** (_Unified Modeling Language_)  
A standardized modeling language for visualizing, specifying, and documenting software systems. In the project, the _UML_ diagrams (class and sequence) are documented in [09_UML_DIAGRAMS.md](09_UML_DIAGRAMS.md).

**Vercel**  
A _deployment_ platform for static and dynamic _frontend_ applications, with free plans. In the project, _Vercel_ is used to host the institutional website and the _Flutter_ Web application, ensuring the same base domain for _localStorage_ sharing.

**Viewport**  
The visible area of a web page or application on a screen, defined by the current display boundaries. In the project, the map area uses dynamic _viewport_ to load only the hotels visible in the map area, optimizing performance and user experience.

**WBS** (_Work Breakdown Structure_)  
A hierarchical decomposition of the work to be performed in a project, organized into work packages. In the project, the _WBS_ is documented in [03_WBS.md](03_WBS.md) and organizes the work into six main phases, with incremental deliveries.

**Webhook**  
A mechanism that allows one application to send real‑time notifications to another application when a specific event occurs. In the project, the _Stripe_ _webhook_ notifies the _Go_ _backend_ when a payment is successfully processed, triggering the unlocking of premium content.

---

_This glossary will be updated whenever new technical terms are introduced in the project documents._
