# Functional and Non-Functional Requirements Specification – _The Doghouse_

## 1. Introduction

This document aims to specify the functional and non-functional requirements of the _The Doghouse_ system. The requirements specification constitutes the foundation for the design, implementation, and testing phases of the project, ensuring that all system functionalities and properties are clearly defined and aligned with user needs.

Functional requirements describe the features the system must offer, organized by functional module. Non-functional requirements describe system properties such as usability, performance, security, and maintainability.

Each functional requirement is prioritized according to the following scale:

- **Essential (Must Have)** – Mandatory requirement for the _MVP_. Without it, the system does not fulfill its fundamental purpose.
- **Important (Should Have)** – Desirable requirement for the _MVP_, but can be deferred to a future version if time is limited.
- **Optional (Could Have)** – Requirement that adds value but is not critical for the _MVP_. Reserved for future versions.

## 2. Functional Requirements

### 2.1. Authentication and User Management Module

**RF01 – User Registration (Essential)**  
The system must allow new users to register using an email address. The registration process occurs in two phases: the user enters the email address (mandatory) and requests a _magic link_; after clicking the link, the user is authenticated and the system registers the account. The user's name is collected only when they access their profile (optional, editable later). After complete registration, the system sends a welcome email. If the email already exists, the system must reject the _magic link_ request with an appropriate message.

**RF02 – _Magic Link_ Authentication (Essential)**  
The system must allow user authentication via a _magic link_ sent by email. The link must have a 15-minute validity period and be single-use.

**RF03 – Social Login Authentication (Essential)**  
The system must allow user authentication via social login with _Google_ and/or _Facebook_.

**RF04 – Exclusion of Traditional Method (Essential)**  
The system must not support the traditional authentication method with email and password. Authentication is exclusively via _magic link_ or social login.

**RF05 – JWT Session Management (Essential)**  
The system must maintain the authenticated user's session through a JWT token with a 7-day validity period, renewable upon re-authentication.

**RF06 – Profile Editing (Important)**  
The system must allow users to view and edit their profile (name, email). The email cannot be changed without re-authentication.

### 2.2. _Seamless_ Navigation Module

**RF07 – _Seamless_ Transition Between Website and Application (Essential)**  
The system must allow a _seamless_ transition between the institutional website (_HTML_/_CSS_/_JS_) and the _Flutter_ application, maintaining the active session without requiring re-authentication. The transition is implemented through a JWT stored in _localStorage_. When the user navigates from the _HTML_ website to the _Flutter_ application, the system redirects to the application with the JWT token in the _URL_ (e.g., `app.thedoghouse.vercel.app?token=JWT_TOKEN`). The _Flutter_ application extracts the token from the _URL_, stores it in _localStorage_, and validates it with the _backend_ to restore the session.

**RF08 – Access to Restricted Area from the _Blog_ (Essential)**  
The system must allow authenticated users, while browsing the institutional website's _blog_, to click a button to access the restricted area in the _Flutter_ application, being redirected with the session already active through the mechanism described in RF07.

**RF09 – _Blog_ Accessible Without Authentication (Essential)**  
The system must ensure that the _blog_ is accessible to all visitors without requiring authentication.

### 2.3. Ideal Weight Calculator Module

**RF10 – Calculator Availability (Essential)**  
The system must provide an ideal weight calculator for dogs, where the user can select the breed (from a predefined list) and enter the animal's age.

**RF11 – Free Version with Approximate Value (Essential)**  
The free version of the calculator must return an approximate ideal weight value for the selected breed and age.

**RF12 – Premium Version with Complete Table (Essential)**  
The premium version of the calculator must return a complete table with percentiles, growth curves, and personalized dietary recommendations. Access to the premium calculator can be obtained in three ways: purchase as an independent product; inclusion in the complete present _bundle_; or inclusion in the lifetime _bundle_. The purchase of individual videos does not grant access to the premium calculator.

**RF13 – Results History (Important)**  
The system must allow premium users to save calculator results for future consultation (weight history).

**RF14 – Call to Action in the Free Version (Essential)**  
The system must present, in the free version, a clear message indicating that the complete table is available in the premium version, with a button to purchase (as an independent product or through a _bundle_).

### 2.4. _Workshops_ Module

**RF15 – _Workshops_ Area Organized by Breed (Essential)**  
The system must provide a _workshops_ area organized by breed, where each breed has a free introductory video.

**RF16 – Paid Videos by Breed (Essential)**  
For each breed, the system must provide a set of paid videos on specific care, nutrition, training, and health.

**RF17 – Purchase of Individual Videos (Essential)**  
The system must allow the purchase of individual videos (one‑time purchase).

**RF18 – Complete Present _Bundle_ (Essential)**  
The system must allow the purchase of a complete present _bundle_ (all videos of all breeds existing at the time of purchase), which also includes access to the premium calculator.

**RF19 – Lifetime _Bundle_ (Important)**  
The system must allow the purchase of a lifetime _bundle_ (all existing and future videos), which also includes access to the premium calculator.

**RF20 – Indication of Locked Content (Essential)**  
The system must present paid content with a clear indication that it is locked, with a button to purchase.

**RF21 – Restricted Access to Introductory Videos (Essential)**  
The system must allow free users to watch only the introductory videos.

**RF22 – Lifetime Access (Essential)**  
The system must ensure that premium users have lifetime access to the content they have purchased.

### 2.5. Maps Module with _Overpass API_

**RF23 – Free Interactive Map (Essential)**  
The system must provide an interactive map for searching _pet‑friendly_ hotels, accessible to all authenticated users, with no distinction between free and premium. This feature is free for all authenticated users, functioning as a loyalty element, while monetization is concentrated on the premium calculator and paid _workshops_.

**RF24 – Search by Current Location (Essential)**  
The system must allow users to search for hotels through the device's current location (Near Me button), obtained via _geolocator_.

**RF25 – Search by Text Location (Essential)**  
The system must allow users to search for hotels by text location (e.g., "Porto"), using the _Nominatim_ geocoding service to convert the text into coordinates.

**RF26 – Integration with _Overpass API_ (Essential)**  
The system must obtain _pet‑friendly_ hotel data through the _Overpass API_ (_OpenStreetMap_), using the tags `dog=yes` or `pets=yes`.

**RF27 – Dynamic Loading by _Viewport_ (Essential)**  
The system must load only the hotels visible in the current map _viewport_ (dynamic loading), sending the _viewport_ boundaries (north, south, east, west) to the _backend_.

**RF28 – Cache with 24‑hour TTL (Essential)**  
The system must cache data obtained via the _Overpass API_ with a 24‑hour TTL, with automatic cleanup (expired records are removed or not queried), to avoid excessive queries to the external _API_.

**RF29 – Markers with Basic Information (Essential)**  
The system must display hotels as markers on the map, with basic information (name, address, contact) available when clicking on the marker.

**RF30 – Opening in Native Maps Application (Important)**  
The system must provide a button to open the selected location in the device's native maps application (e.g., _Google Maps_ or _Apple Maps_).

**RF31 – Consent for Geolocation (Essential)**  
The system must request explicit consent from the user before accessing their location. The user can decline and use only text‑based search.

### 2.6. Payments and Invoicing Module

**RF32 – Purchase of Premium Content via _Stripe_ (Essential)**  
The system must allow free users to purchase premium content through a _checkout_ process integrated with _Stripe_ (in a _sandbox_ environment).

**RF33 – _Checkout_ Session Creation (Essential)**  
The system must create a _checkout_ session on _Stripe_ when the user clicks Buy now, redirecting the user to the _Stripe_ payment page.

**RF34 – _Stripe Webhook_ Processing (Essential)**  
The system must process the _Stripe_ _webhook_ in the _Go_ _backend_, validating the payment, recording the purchase in the database (associating the user with the acquired content), and recording the purchase date.

**RF35 – _Retry_ Logic for _Webhook_ (Essential)**  
The system must implement a _retry_ logic for the _Stripe_ _webhook_, ensuring that payment notifications reach the _backend_.

**RF36 – _Polling_ in the _Flutter_ Application (Essential)**  
The _Flutter_ application must implement _polling_ to check the purchase status, allowing content unlocking even if the _webhook_ is delayed.

**RF37 – Integration with _Moloni_ for Simulated Invoice (Essential)**  
The system must integrate with _Moloni_ (in a _sandbox_ environment) to generate a simulated invoice in _PDF_ after each successful purchase.

**RF38 – Content of the Simulated Invoice (Essential)**  
The simulated invoice must include the project logo, date, amount, purchase data, and user data, with the appearance of a real invoice, but without legal value or tax effects.

**RF39 – Storage of Invoice _URL_ (Essential)**  
The system must store the public _URL_ of the invoice provided by _Moloni_ in the database, associated with the user and the purchase.

**RF40 – Invoice Viewing and _Download_ (Important)**  
The system must allow premium users to view and _download_ their invoices in the profile area.

**RF41 – Lifetime Access to Premium Content (Essential)**  
The system must ensure that access to premium content is lifetime and does not expire.

### 2.7. Profile and Content Management Module

**RF42 – Profile Area with History (Essential)**  
The system must provide a profile area where the user can view their purchase history, acquired content, and edit their name.

**RF43 – Indication of Unlocked Content (Essential)**  
The system must display acquired content with a clear indication that it is unlocked (e.g., open padlock icon).

**RF44 – Indication of Locked Content (Essential)**  
The system must display non‑acquired content with a clear indication that it is locked (e.g., closed padlock icon) and a button to purchase.

**RF45 – Content Management Without Administration Panel (Essential)**  
Content management (breeds, _workshops_, calculator data, video and thumbnail _URLs_) must be performed directly in the database or through files, with no administration panel within the _MVP_ scope. Videos and images are referenced by _URL_ (e.g., _YouTube_, _Vimeo_, or cloud services), not stored physically in the system. The _MVP_ focus is on business logic (integration with _Go_, _Stripe_, _Moloni_), not multimedia storage.

### 2.8. Notifications and Communication Module

**RF46 – _Magic Link_ Sending by Email (Essential)**  
The system must send an email with the _magic link_ for authentication whenever the user requests it.

**RF47 – Purchase Confirmation by Email (Important)**  
The system must send a purchase confirmation email after successful payment processing.

**RF48 – Welcome Email (Important)**  
The system must send a welcome email after user registration.

## 3. Non‑Functional Requirements

### 3.1. Usability

The system must be intuitive and easy to use, with special attention to the user experience on mobile devices, since the _Flutter_ application will be the primary interface for the restricted area.

**RNF01 – Responsiveness (Essential)**  
The interface must be responsive, adapting to screens of different sizes (mobile, tablet, _desktop_).

**RNF02 – Adequate Touch Target Size (Essential)**  
Interaction elements (buttons, forms) must have adequate size for touch on mobile devices (minimum 44 points in height).

**RNF03 – Visual Feedback After Actions (Essential)**  
Navigation must be clear and intuitive, with visual feedback after each action (success/error messages).

**RNF04 – Reduced Learning Time (Important)**  
Learning time for new users must be reduced, with _tooltips_ or visual indicators on main features.

**RNF05 – Mobile Optimization (Essential)**  
The _landing page_ and the _blog_ must be optimized for reading on mobile devices, with appropriate typography and spacing. The _blog_ is accessible without authentication (RF09).

### 3.2. Performance

The system must respond quickly and efficiently, even under adverse network conditions.

**RNF06 – Response Times (Essential)**  
The response time for the most common operations (authentication, weight calculation, hotel search with _cache_) must not exceed 2 seconds under normal network conditions (4G or Wi‑Fi). Hotel search via _Overpass API_ (first query, without _cache_) may take up to 5 seconds, as it depends on an external free service with no guaranteed SLA. The 24‑hour _cache_ (RF28) reduces the typical time to less than 500 milliseconds.

**RNF07 – Map Loading Optimization (Essential)**  
Map loading with hotels must be optimized, loading only the data visible in the current _viewport_.

**RNF08 – _Flutter_ Application Loading Time (Important)**  
The _Flutter_ application must have an initial loading time of less than 3 seconds on mobile devices with 4G connection.

### 3.3. Security

The system must ensure user data protection and operation integrity.

**RNF09 – _HTTPS_ Communications (Essential)**  
Communications between _frontend_ and _backend_ must use _HTTPS_ in the production environment.

**RNF10 – Profile‑Based Authorization (Essential)**  
Access to each system area requires authentication and authorization based on user profile (free vs. premium).

**RNF11 – Secure Storage of JWT Tokens (Essential)**  
JWT tokens must be stored securely (_localStorage_ or _cookies_ with security flags).

**RNF12 – Consent for Geolocation (Essential)**  
Geolocation must only be obtained after explicit user consent.

**RNF13 – _Rate Limiting_ for _Magic Links_ (Essential)**  
The system must implement _rate limiting_ for _magic link_ requests: maximum of 5 attempts per hour per email address. After exceeding, it returns _HTTP 429 (Too Many Requests)_ with the message "Please wait 1 hour before requesting a new link". Aligns with _OAuth_ standards (_Google_, _Microsoft_).

**RNF14 – Session Expiration (Essential)**  
Sessions must expire after 7 days (or as defined in the system's time constants).

**RNF15 – Input Validation (Essential)**  
The system must validate all user inputs to prevent injection (_SQL_, _XSS_) and other attacks.

**RNF16 – _CORS_ Configuration (Essential)**  
The _backend_ must configure _CORS_ appropriately to allow only authorized subdomains.

### 3.4. Portability

The system must work correctly on major platforms and browsers.

**RNF17 – _Flutter_ Multiplatform Application (Essential)**  
The _Flutter_ application must be compiled and run on three platforms: _Web_ (as _PWA_), _iOS_, and _Android_, sharing the same codebase.

**RNF18 – Browser Compatibility (Essential)**  
The institutional website must work on the latest versions of _Chrome_, _Firefox_, _Safari_ (including _iOS_), and _Edge_ browsers.

**RNF19 – Dual Access on Mobile Devices (Essential)**  
On mobile devices (_iOS_ ≥ 14, _Android_ ≥ 10), the _Flutter_ application will be accessible in two ways: via browser (_PWA_, installable from the _browser_) and via official stores (_App Store_ for _iOS_ and _Play Store_ for _Android_), sharing 100% of the code. The user chooses which form they prefer.

### 3.5. Maintainability

The code must be organized and documented to facilitate future maintenance.

**RNF20 – Layered Organization (Essential)**  
The _Go_ _backend_ must be organized in layers (routes, controllers, services, data access).

**RNF21 – Versioning in _Git_ (Essential)**  
The code must be versioned in _Git_, with a public repository on _GitHub_.

**RNF22 – Database Documentation (Essential)**  
The database must be documented (entity‑relationship diagram and data dictionary).

**RNF23 – Code Comments (Important)**  
The code must include comments in _Go_ and _Flutter_ for complex logic, ensuring readability. Full documentation (_Javadoc‑style_) is not required in the _MVP_.

**RNF24 – Technical _README_ (Important)**  
The repository must include a technical _README_ with instructions for configuring and running the project.

### 3.6. Image and Multimedia Storage

**RNF25 – _URL_ Referencing (Essential)**  
The system does not store multimedia files (images, videos) locally. All multimedia content is referenced by _URL_ (e.g., _YouTube_, _Vimeo_, _Cloudinary_, or other services), inserted directly into the database or configuration files.

**RNF26 – No Image Uploads (Essential)**  
There is no image upload by users in the _MVP_. The project focus is on business logic (integration with _Go_, _Stripe_, _Moloni_, _Overpass API_), not multimedia storage.

### 3.7. Infrastructure and Availability

**RNF27 – _Backend_ Hosting in Containers (Essential)**  
The _Go_ _backend_ will be hosted on a container service (e.g., _Render_, _Fly.io_, _Railway_) with free plans.

**RNF28 – Database on _Neon_ (Essential)**  
The _PostgreSQL_ database will be hosted on _Neon_ (free plan with 500 MB of storage). This limit is adequate because the database stores only metadata (users, purchases, content, temporary _Overpass API_ _cache_ with automatic cleanup) and no multimedia files. The _Overpass API_ _cache_ is periodically cleaned (24‑hour TTL, expired records are removed or not queried).

**RNF29 – Website and _Flutter Web_ on _Vercel_ (Essential)**  
The institutional website and the _Flutter Web_ application will be hosted on distinct services: both the website and _Flutter Web_ on _Vercel_ (same base domain, allowing _localStorage_ sharing).

**RNF30 – Tolerance to _Cold Starts_ and Limits (Essential)**  
Deployment platforms may impose _cold starts_ (delay on first access after inactivity) and bandwidth or storage limits. The system must tolerate these limitations.

**RNF31 – Store Publishing (Essential)**  
The application will be published on the _App Store_ and _Play Store_ using developer accounts (the author already has the accounts created).

**RNF32 – Environment Variable Management (Essential)**  
_API_ keys and sensitive configurations must be managed through environment variables.

### 3.8. Monitoring and _Logging_

**RNF33 – Error Tracking (Important)**  
The system must integrate an error tracking tool (e.g., _Sentry_) to monitor production failures.

**RNF34 – Centralized _Logging_ (Important)**  
The _backend_ must implement centralized _logging_ to record requests, errors, and critical events.

**RNF35 – Critical Failure Alerts (Important)**  
The system must set up alerts for critical failures (e.g., unprocessed _Stripe_ _webhook_).

### 3.9. Prototype Limitations

The system is an _MVP_ developed in a learning context and is not intended to meet all requirements of a production system. The following limitations are assumed:

**RNF36** – The system does not implement a detailed audit log.

**RNF37** – The system has no protection against _DDoS_ attacks.

**RNF38** – _Stripe_ and _Moloni_ are used in _sandbox_ mode, without real tax effects.

**RNF39** – Email notifications are implemented with free services (e.g., _SendGrid_, _Mailgun_, _Resend_).

**RNF40** – _PDF_ generation for invoices is delegated to _Moloni_ (in _sandbox_).

**RNF41** – Map location uses _Overpass API_ and _Nominatim_ (free _OpenStreetMap_ services).

**RNF42** – The system does not include an administration panel for content management; data is inserted directly into the database or through files.

**RNF43** – Multimedia content (videos, images) is referenced by _URL_, not stored locally.

**RNF44** – The _PostgreSQL_ database on _Neon_ has a 500 MB storage limit, adequate for the _MVP_.

## 4. Traceability Matrix

The traceability matrix presented in Table 1 establishes the correlation between each functional requirement, the user profile it targets, its priority, the system module it belongs to, and the current implementation status within the _MVP_ scope. This matrix allows verification of requirements coverage and serves as a project scope management tool.

_Table 1 – Functional requirements traceability_

**Legend for Table 1:**

The terms used in the traceability table have the following meanings. The Visitor profile refers to the unauthenticated user, with access only to the _landing page_ and the _blog_. The Free User profile corresponds to the authenticated user, with access to free content, including the basic calculator, introductory _workshops_, and the map. The Premium User profile identifies the authenticated user who has acquired premium content, such as the complete calculator and paid _workshops_. Regarding priorities, the Essential classification indicates a mandatory requirement for the _MVP_, without which the system does not fulfill its fundamental purpose, while the Important classification indicates a desirable requirement that may be deferred to a future version. Finally, the status "Not implemented" reflects the current project condition, since the development phase has not yet begun.

| Requirement | Profile             | Priority  | System Module                      | Current Status  |
| ----------- | ------------------- | --------- | ---------------------------------- | --------------- |
| RF01        | Visitor / Free User | Essential | Authentication and User Management | Not implemented |
| RF02        | Free User / Premium | Essential | Authentication and User Management | Not implemented |
| RF03        | Free User / Premium | Essential | Authentication and User Management | Not implemented |
| RF04        | Free User / Premium | Essential | Authentication and User Management | Not implemented |
| RF05        | Free User / Premium | Essential | Authentication and User Management | Not implemented |
| RF06        | Free User / Premium | Important | Authentication and User Management | Not implemented |
| RF07        | Free User / Premium | Essential | _Seamless_ Navigation              | Not implemented |
| RF08        | Free User / Premium | Essential | _Seamless_ Navigation              | Not implemented |
| RF09        | Visitor             | Essential | _Seamless_ Navigation              | Not implemented |
| RF10        | Free User / Premium | Essential | Ideal Weight Calculator            | Not implemented |
| RF11        | Free User           | Essential | Ideal Weight Calculator            | Not implemented |
| RF12        | Premium User        | Essential | Ideal Weight Calculator            | Not implemented |
| RF13        | Premium User        | Important | Ideal Weight Calculator            | Not implemented |
| RF14        | Free User           | Essential | Ideal Weight Calculator            | Not implemented |
| RF15        | Free User / Premium | Essential | _Workshops_                        | Not implemented |
| RF16        | Premium User        | Essential | _Workshops_                        | Not implemented |
| RF17        | Premium User        | Essential | _Workshops_                        | Not implemented |
| RF18        | Premium User        | Essential | _Workshops_                        | Not implemented |
| RF19        | Premium User        | Important | _Workshops_                        | Not implemented |
| RF20        | Free User / Premium | Essential | _Workshops_                        | Not implemented |
| RF21        | Free User           | Essential | _Workshops_                        | Not implemented |
| RF22        | Premium User        | Essential | _Workshops_                        | Not implemented |
| RF23        | Free User / Premium | Essential | Maps with _Overpass API_           | Not implemented |
| RF24        | Free User / Premium | Essential | Maps with _Overpass API_           | Not implemented |
| RF25        | Free User / Premium | Essential | Maps with _Overpass API_           | Not implemented |
| RF26        | Free User / Premium | Essential | Maps with _Overpass API_           | Not implemented |
| RF27        | Free User / Premium | Essential | Maps with _Overpass API_           | Not implemented |
| RF28        | Free User / Premium | Essential | Maps with _Overpass API_           | Not implemented |
| RF29        | Free User / Premium | Essential | Maps with _Overpass API_           | Not implemented |
| RF30        | Free User / Premium | Important | Maps with _Overpass API_           | Not implemented |
| RF31        | Free User / Premium | Essential | Maps with _Overpass API_           | Not implemented |
| RF32        | Free User           | Essential | Payments and Invoicing             | Not implemented |
| RF33        | Free User           | Essential | Payments and Invoicing             | Not implemented |
| RF34        | Free User / Premium | Essential | Payments and Invoicing             | Not implemented |
| RF35        | Free User / Premium | Essential | Payments and Invoicing             | Not implemented |
| RF36        | Free User / Premium | Essential | Payments and Invoicing             | Not implemented |
| RF37        | Free User / Premium | Essential | Payments and Invoicing             | Not implemented |
| RF38        | Free User / Premium | Essential | Payments and Invoicing             | Not implemented |
| RF39        | Free User / Premium | Essential | Payments and Invoicing             | Not implemented |
| RF40        | Premium User        | Important | Payments and Invoicing             | Not implemented |
| RF41        | Premium User        | Essential | Payments and Invoicing             | Not implemented |
| RF42        | Free User / Premium | Essential | Profile and Content Management     | Not implemented |
| RF43        | Free User / Premium | Essential | Profile and Content Management     | Not implemented |
| RF44        | Free User / Premium | Essential | Profile and Content Management     | Not implemented |
| RF45        | Free User / Premium | Essential | Profile and Content Management     | Not implemented |
| RF46        | Free User / Premium | Essential | Notifications and Communication    | Not implemented |
| RF47        | Premium User        | Important | Notifications and Communication    | Not implemented |
| RF48        | Free User / Premium | Important | Notifications and Communication    | Not implemented |

## 5. Conclusion

The functional and non‑functional requirements specification presented in this document clearly and structurally defines what the _The Doghouse_ system must do and how it must behave. The functional requirements, organized by module and priority, establish the essential features for the _MVP_ and identify areas that can be expanded in future versions. The non‑functional requirements ensure that the system will be usable, secure, performant, and maintainable. The traceability matrix presented in Table 1 allows verification of requirements coverage and serves as a project scope management tool.

This document will serve as a guide for the design, implementation, and testing phases, ensuring that the _MVP_ meets the objectives defined in the project scope.
