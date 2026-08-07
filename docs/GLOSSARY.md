# Technical Glossary – _The Doghouse_

## Introduction

This glossary aims to define the technical terms used throughout the documentation of the _The Doghouse_ project. The definitions are contextualized for the project's scope, ensuring that all readers, regardless of their familiarity with the technologies involved, can understand the concepts presented.

This glossary will be updated whenever new technical terms are introduced in the project documents.

## List of Terms

**API** (Application Programming Interface)

A set of rules and protocols that enables communication between software systems. In the project, the REST API developed in Go serves as the connection point between the frontend (institutional website and Flutter application) and the database, enabling data exchange.

**Bundle**

A package of content or features sold as a set at a special price. In the project, paid workshops can be purchased in bundles (by breed, complete present, or lifetime), offering flexibility and added value to the user.

**Cold Start**

Initial delay in starting an application after a period of inactivity, common in cloud services that suspend inactive containers to save resources. In the project, the Go backend, hosted on services like Render or Fly.io, may experience cold starts, which is acceptable for an MVP without critical latency requirements.

**Containerization**

A virtualization technique that allows packaging an application and all its dependencies into an isolated container, ensuring consistency between development and production environments. In the project, Docker is used to containerize the Go backend, the PostgreSQL database, and the proxy, facilitating deployment and reproducibility.

**CORS** (Cross-Origin Resource Sharing)

A security mechanism that controls how resources from one domain are accessed by applications from other domains. In the project, CORS is configured in the Go backend to allow the institutional website (`site.thedoghouse.netlify.app`) and the Flutter application (`app.thedoghouse.netlify.app`) to make secure requests to the API (`api.thedoghouse.onrender.com`).

**CRUD** (Create, Read, Update, Delete)

An acronym for the four basic data manipulation operations in information systems. In the project, CRUD operations are used to manage users, breeds, workshops, and other content in the database.

**Disaster Recovery**

A plan and process for recovering an application after critical failures, ensuring service continuity. In the project, Disaster Recovery covers backup and database restoration procedures, as well as deployment rollbacks.

**Docstring**

Structured comments within functions and classes that describe their purpose, parameters, and return values. In the project, docstrings in Go and Flutter ensure that the code is self-documenting and easy to maintain.

**Email Service**

A transactional email service used to send magic links to users. In the project, services like SendGrid, Mailgun, or Resend are used to deliver authentication emails securely and reliably.

**Geolocator**

A Flutter package used to obtain the device's geographic location (latitude and longitude coordinates) with the user's consent. In the project, the geolocator is used to center the map on the user's location in the Near Me feature.

**Git / GitHub**

A distributed version control system and hosting platform. In the project, the public GitHub repository stores all source code, facilitating versioning and collaboration.

**JSON-LD** (JSON for Linking Data)

A format for structuring data in JSON with well-defined semantics, primarily used in SEO. In the project, JSON-LD is used to describe data structure (e.g., blog articles) to search engines.

**JWT** (JSON Web Token)

An open standard for the secure representation of claims between two parties. In the project, the JWT is used to maintain the authenticated user's session, stored in localStorage and shared between the institutional website and the Flutter application for seamless transition. The token is valid for 7 days and is renewable.

**Logging**

The process of recording events and activities of an application in files or centralized services. In the project, centralized logging in the Go backend allows tracking requests, errors, and critical events for debugging and analysis.

**Magic Link**

An authentication link sent by email that allows the user to log in without providing a password. In the project, the magic link is one of the two supported authentication methods, with a 15-minute validity period and single use.

**Nominatim**

A free geocoding service based on OpenStreetMap data that converts addresses and place names into geographic coordinates (latitude and longitude). In the project, Nominatim allows users to search for hotels by locality name (e.g., "Porto") in the maps area, rather than only requesting location.

**OAuth** (Open Authorization)

An open authorization protocol that allows users to authenticate through third parties (e.g., Google, Facebook) without sharing passwords. In the project, OAuth is used to implement social login, allowing users to register or authenticate through Google or Facebook.

**ORM** (Object-Relational Mapping)

A technique that maps objects from a programming language to tables in a relational database. In the project, the ORM is used in the Go backend to simplify interaction with the PostgreSQL database, abstracting the programmer from writing manual SQL queries.

**Overpass API**

A public API that allows querying OpenStreetMap geospatial data in a structured way. In the project, the Overpass API is the primary data source for obtaining pet-friendly hotels based on location, using the tags `dog=yes` or `pets=yes`.

**Polling**

A communication technique where a client periodically checks a server for new data or updates. In the project, the Flutter application implements polling to verify if a Stripe payment webhook has been processed, allowing premium content to be unlocked even if the webhook is delayed.

**PWA** (Progressive Web App)

A web application that uses modern technologies to offer an experience similar to a native application. In the project, the Flutter application is configured as a PWA, allowing direct installation from the browser without the need for app stores.

**Rate Limiting**

An access control technique that limits the number of requests from a client in a specific time period. In the project, rate limiting is implemented in authentication to prevent brute force attacks, limiting the number of magic link requests to 5 per hour per email address.

**REST** (Representational State Transfer)

An architectural style for APIs that uses HTTP as the communication protocol, with well-defined operations (GET, POST, PUT, DELETE) and responses in formats such as JSON. In the project, the REST API in Go is the standardized interface for all system operations.

**Retry Logic**

A mechanism that automatically attempts to repeat a failed operation multiple times with increasing intervals. In the project, Stripe implements automatic retry for undelivered webhooks, ensuring that payment notifications reach the backend.

**Rollback**

The process of reverting an update or deployment to a previous version in case of failure or issues. In the project, rollback is documented for the Go backend and the Flutter application, allowing quick reversion to a stable version if a deployment introduces bugs.

**Sandbox**

An isolated testing environment that simulates a production environment without affecting real data or production systems. In the project, Stripe and Moloni are used in sandbox mode, allowing payment and invoice simulations without real tax effects.

**Seamless** (continuous transition)

A fluid and continuous navigation experience between different parts of a system, without noticeable interruptions. In the project, the seamless transition between the institutional website and the Flutter application allows the authenticated user to navigate between both without repeating the login.

**Sentry**

A real-time error tracking platform that captures and reports exceptions and errors in applications. In the project, Sentry is integrated into the Go backend to monitor production failures.

**SEO** (Search Engine Optimization)

A set of practices to improve a website's visibility in search engines. In the project, the blog and landing page use technical SEO (meta tags, JSON-LD, HTML semantics) to attract organic traffic.

**Service Worker**

A JavaScript script that runs in the background of the browser, enabling offline features and resource caching. In the project, the service worker is configured in the PWA to allow offline access to the application and installation as a browser app.

**TTL** (Time To Live)

The period during which data is considered valid and stored in cache before being considered obsolete. In the project, data obtained via the Overpass API is stored in cache with a TTL of 24 hours, avoiding excessive queries to the external API.

**Viewport**

The visible area of a web page or application on a screen, defined by the current display boundaries. In the project, the map area uses dynamic viewport to load only the hotels visible in the map area, optimizing performance and user experience.

**Webhook**

A mechanism that allows an application to send real-time notifications to another application when a specific event occurs. In the project, the Stripe webhook notifies the Go backend when a payment is successfully processed, triggering the unlocking of premium content.

---

_This glossary will be updated whenever new technical terms are introduced in the project documents._
