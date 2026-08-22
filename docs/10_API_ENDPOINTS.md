# API Endpoints Definition and Interaction Flows – _The Doghouse_

## 1. Introduction

The _REST API_ endpoints specification constitutes the bridge between the architecture design and the implementation of the _The Doghouse_ system. Based on the functional requirements and the previously elaborated sequence diagrams, this document defines the set of routes that the _Go_ _backend_ must provide, the allowed _HTTP_ methods, the expected parameters, the response formats, and the access permissions for each user profile.

This specification follows the _REST_ style, with communication in _JSON_ over _HTTPS_, and requires authentication via JWT _token_ (except for public _endpoints_ such as registration and social _login_). The organization of the _endpoints_ reflects the main flows identified in the sequence diagrams:

- Authentication (_magic link_ and social _login_)
- Content (breeds, calculator, _workshops_)
- Maps (hotel search, geocoding)
- Payments and invoicing (_Stripe_, _Moloni_)
- User profile and history

**Important note:** This specification is a guide for the initial implementation. The _endpoints_ and interaction flows may undergo adjustments during the development phase, as additional details or unforeseen needs arise during the design phase. The final implementation should reflect the decisions made during development, maintaining coherence with the defined architecture.

## 2. General Conventions

### 2.1. Authentication

Most _endpoints_ require authentication through a JWT _token_, which must be sent in the _Authorization_ header:

```
Authorization: Bearer <jwt_token>
```

Public _endpoints_ (registration, social _login_, _magic link_ request) do not require authentication.

### 2.2. User Profiles

The system has three access profiles:

| Profile          | Description                                                                                            |
| ---------------- | ------------------------------------------------------------------------------------------------------ |
| **Public**       | Unauthenticated user. Only accesses the _landing page_ and the _blog_.                                 |
| **Free User**    | Authenticated user. Accesses the basic calculator, free _workshops_, and the map.                      |
| **Premium User** | Authenticated user with purchases. Accesses _premium_ content (complete calculator, paid _workshops_). |

### 2.3. Response Codes

| Code                        | Meaning                                               |
| --------------------------- | ----------------------------------------------------- |
| `200 OK`                    | Request successful.                                   |
| `201 Created`               | Resource successfully created.                        |
| `400 Bad Request`           | Invalid or missing parameters.                        |
| `401 Unauthorized`          | Authentication required or invalid _token_.           |
| `403 Forbidden`             | User does not have permission to access the resource. |
| `404 Not Found`             | Resource not found.                                   |
| `429 Too Many Requests`     | Attempt limit exceeded (_rate limiting_).             |
| `500 Internal Server Error` | Internal server error.                                |

### 2.4. Standard Response Structure

All responses follow a common structure:

```json
{
  "success": true,
  "data": { ... },
  "message": "Operation completed successfully",
  "errors": []
}
```

In case of error:

```json
{
  "success": false,
  "data": null,
  "message": "Error processing the request",
  "errors": [{ "field": "email", "message": "Email already registered" }]
}
```

## 3. API _Endpoints_

### 3.1. Authentication

| Method | Path                   | Profile | Description                                                                                       |
| ------ | ---------------------- | ------- | ------------------------------------------------------------------------------------------------- |
| `POST` | `/api/auth/magic-link` | Public  | Requests sending a _magic link_ to the provided email. Applies _rate limiting_ (5 attempts/hour). |
| `GET`  | `/api/auth/verify`     | Public  | Validates the _magic link_ _token_, authenticates the user, and returns JWT.                      |
| `POST` | `/api/auth/social`     | Public  | Authentication via social _login_ (_Google_/_Facebook_). Returns JWT.                             |
| `GET`  | `/api/auth/me`         | Free    | Gets the authenticated user's data.                                                               |

#### 3.1.1. `POST /api/auth/magic-link`

**Description:** Requests sending a _magic link_ to the provided email.

**Request Body:**

```json
{
  "email": "user@example.com"
}
```

**Response (200 OK):**

```json
{
  "success": true,
  "message": "Link sent to your email"
}
```

**Response (429 Too Many Requests):**

```json
{
  "success": false,
  "message": "Please wait 1 hour before requesting a new link"
}
```

#### 3.1.2. `GET /api/auth/verify`

**Description:** Validates the _magic link_ _token_ and authenticates the user.

**Query Parameters:**
| Parameter | Type | Description |
|-----------|------|-------------|
| `token` | `string` | _Token_ received by email. |

**Response (200 OK):**

```json
{
  "success": true,
  "data": {
    "jwt": "eyJhbGciOiJIUzI1NiIs...",
    "user": {
      "id": "550e8400-e29b-41d4-a716-446655440000",
      "email": "user@example.com",
      "name": "John Doe",
      "registeredAt": "2026-08-22T10:00:00Z"
    }
  }
}
```

**Response (401 Unauthorized):**

```json
{
  "success": false,
  "message": "Invalid or expired link"
}
```

#### 3.1.3. `POST /api/auth/social`

**Description:** Authentication via social _login_ (_Google_/_Facebook_).

**Request Body:**

```json
{
  "provider": "google", // or "facebook"
  "token": "id_token_or_access_token"
}
```

**Response (200 OK):** Same as `GET /api/auth/verify`.

#### 3.1.4. `GET /api/auth/me`

**Description:** Gets the authenticated user's data.

**Headers:** `Authorization: Bearer <jwt>`

**Response (200 OK):**

```json
{
  "success": true,
  "data": {
    "id": "550e8400-e29b-41d4-a716-446655440000",
    "email": "user@example.com",
    "name": "John Doe",
    "registeredAt": "2026-08-22T10:00:00Z",
    "lastAccess": "2026-08-22T14:30:00Z",
    "purchases": [
      {
        "id": 456,
        "contentId": 123,
        "contentTitle": "Nutrition Workshop",
        "amount": 9.99,
        "purchasedAt": "2026-08-22T12:00:00Z",
        "status": "completed"
      }
    ]
  }
}
```

### 3.2. Content

| Method | Path                        | Profile   | Description                                                              |
| ------ | --------------------------- | --------- | ------------------------------------------------------------------------ |
| `GET`  | `/api/breeds`               | Public    | Lists all available breeds.                                              |
| `GET`  | `/api/breeds/{id}`          | Public    | Gets details of a specific breed.                                        |
| `GET`  | `/api/calculator/weight`    | Free      | Calculates ideal weight (free version, approximate value).               |
| `GET`  | `/api/calculator/premium`   | _Premium_ | Calculates ideal weight with complete table (requires _premium_ access). |
| `GET`  | `/api/workshops`            | Free      | Lists breeds with free introductory videos.                              |
| `GET`  | `/api/workshops/{breedId}`  | Free      | Gets videos of a specific breed (paid videos locked if no access).       |
| `GET`  | `/api/contents`             | Free      | Lists all available content (with access indication).                    |
| `GET`  | `/api/contents/{id}`        | Free      | Gets details of a specific content.                                      |
| `GET`  | `/api/contents/{id}/access` | Free      | Checks if the user has access to the content.                            |

#### 3.2.1. `GET /api/calculator/weight`

**Description:** Calculates ideal weight for a breed and age (free version, approximate value).

**Query Parameters:**
| Parameter | Type | Description |
|-----------|------|-------------|
| `breedId` | `integer` | Breed identifier. |
| `age` | `decimal` | Dog's age (in months). |

**Response (200 OK):**

```json
{
  "success": true,
  "data": {
    "breed": "Golden Retriever",
    "age": 6,
    "weight": 8.5,
    "message": "Approximate ideal weight for the indicated age"
  }
}
```

#### 3.2.2. `GET /api/calculator/premium`

**Description:** Calculates ideal weight with complete table (percentiles, growth curves, recommendations). Requires _premium_ access.

**Headers:** `Authorization: Bearer <jwt>`

**Query Parameters:**
| Parameter | Type | Description |
|-----------|------|-------------|
| `breedId` | `integer` | Breed identifier. |
| `age` | `decimal` | Dog's age (in months). |

**Response (200 OK):**

```json
{
  "success": true,
  "data": {
    "breed": "Golden Retriever",
    "age": 6,
    "table": {
      "percentiles": [
        { "percentile": 10, "weight": 6.2 },
        { "percentile": 50, "weight": 8.5 },
        { "percentile": 90, "weight": 10.8 }
      ],
      "growthCurve": [ ... ],
      "recommendations": "High-protein diet..."
    }
  }
}
```

**Response (403 Forbidden):**

```json
{
  "success": false,
  "message": "Premium access required. Purchase the premium calculator."
}
```

#### 3.2.3. `GET /api/workshops/{breedId}`

**Description:** Gets videos of a specific breed. Paid videos are returned with `locked: true` if the user does not have access.

**Headers:** `Authorization: Bearer <jwt>`

**Query Parameters:**
| Parameter | Type | Description |
|-----------|------|-------------|
| `breedId` | `integer` | Breed identifier. |

**Response (200 OK):**

```json
{
  "success": true,
  "data": {
    "breedId": 1,
    "breedName": "Golden Retriever",
    "videos": [
      {
        "id": 101,
        "title": "Introduction to the Golden Retriever",
        "description": "General characteristics of the breed",
        "isFree": true,
        "url": "https://youtube.com/embed/abc123",
        "locked": false
      },
      {
        "id": 102,
        "title": "Nutrition for Golden Retrievers",
        "description": "Balanced diet for the breed",
        "isFree": false,
        "url": "https://youtube.com/embed/def456",
        "locked": true,
        "price": 9.99
      }
    ]
  }
}
```

#### 3.2.4. `GET /api/contents/{id}`

**Description:** Gets details of a specific content, including whether the user has access (`locked` field).

**Headers:** `Authorization: Bearer <jwt>`

**Response (200 OK):**

```json
{
  "success": true,
  "data": {
    "id": 123,
    "type": "video",
    "title": "Nutrition Workshop",
    "description": "Learn how to feed your dog a balanced diet",
    "price": 9.99,
    "isFree": false,
    "url": "https://youtube.com/embed/def456",
    "locked": true
  }
}
```

#### 3.2.5. `GET /api/contents/{id}/access`

**Description:** Checks if the authenticated user has access to a specific content (via direct purchase or bundle). Follows the access resolution algorithm.

**Headers:** `Authorization: Bearer <jwt>`

**Response (200 OK) – Access granted:**

```json
{
  "success": true,
  "data": {
    "hasAccess": true,
    "type": "direct" // or "bundle", "calculator_premium_direct", "calculator_premium_bundle"
  }
}
```

**Response (200 OK) – Access denied:**

```json
{
  "success": true,
  "data": {
    "hasAccess": false,
    "locked": true
  }
}
```

### 3.3. Maps

| Method | Path                | Profile | Description                                               |
| ------ | ------------------- | ------- | --------------------------------------------------------- |
| `GET`  | `/api/maps/hotels`  | Free    | Searches _pet-friendly_ hotels in the current _viewport_. |
| `GET`  | `/api/maps/geocode` | Free    | Geocodes a text address into coordinates (_Nominatim_).   |

#### 3.3.1. `GET /api/maps/hotels`

**Description:** Searches _pet-friendly_ hotels in the current _viewport_. The query checks the _cache_ before calling the _Overpass API_.

**Query Parameters:**
| Parameter | Type | Description |
|-----------|------|-------------|
| `lat` | `decimal` | Latitude of the _viewport_ center. |
| `lng` | `decimal` | Longitude of the _viewport_ center. |
| `north` | `decimal` | North limit of the _viewport_. |
| `south` | `decimal` | South limit of the _viewport_. |
| `east` | `decimal` | East limit of the _viewport_. |
| `west` | `decimal` | West limit of the _viewport_. |

**Response (200 OK):**

```json
{
  "success": true,
  "data": {
    "source": "cache", // or "overpass"
    "hotels": [
      {
        "id": "node123",
        "name": "Hotel Pet Paradise",
        "address": "123 Flower Street",
        "lat": 41.1579,
        "lon": -8.6291,
        "phone": "+351 123 456 789",
        "tags": { "dog": "yes", "pets": "yes" }
      }
    ]
  }
}
```

#### 3.3.2. `GET /api/maps/geocode`

**Description:** Geocodes a text address into coordinates using _Nominatim_.

**Query Parameters:**
| Parameter | Type | Description |
|-----------|------|-------------|
| `address` | `string` | Address to geocode (e.g., "Porto"). |

**Response (200 OK):**

```json
{
  "success": true,
  "data": {
    "lat": 41.1579,
    "lng": -8.6291,
    "displayName": "Porto, Portugal"
  }
}
```

### 3.4. Payments

| Method | Path                                | Profile | Description                                                 |
| ------ | ----------------------------------- | ------- | ----------------------------------------------------------- |
| `POST` | `/api/payments/create-checkout`     | Free    | Creates a _checkout_ session on _Stripe_.                   |
| `POST` | `/api/payments/webhook`             | Public  | _Endpoint_ for the _Stripe_ _webhook_ (payment processing). |
| `GET`  | `/api/payments/status/{purchaseId}` | Free    | Checks the status of a purchase (_polling_).                |

#### 3.4.1. `POST /api/payments/create-checkout`

**Description:** Creates a _checkout_ session on _Stripe_ for a specific content.

**Headers:** `Authorization: Bearer <jwt>`

**Request Body:**

```json
{
  "contentId": 123
}
```

**Response (200 OK):**

```json
{
  "success": true,
  "data": {
    "purchaseId": 456,
    "checkoutUrl": "https://checkout.stripe.com/c/pay/abc123"
  }
}
```

#### 3.4.2. `POST /api/payments/webhook`

**Description:** _Endpoint_ for the _Stripe_ _webhook_. Does not require authentication (the _webhook_ signature is validated internally).

**Headers:** `Stripe-Signature: ...`

**Request Body:** (sent by _Stripe_)

**Response (200 OK):**

```json
{
  "received": true
}
```

#### 3.4.3. `GET /api/payments/status/{purchaseId}`

**Description:** Checks the status of a purchase (used for _polling_ by the _Flutter_ application).

**Headers:** `Authorization: Bearer <jwt>`

**Response (200 OK):**

```json
{
  "success": true,
  "data": {
    "purchaseId": 456,
    "status": "pending", // or "completed", "failed"
    "contentId": 123,
    "contentTitle": "Nutrition Workshop"
  }
}
```

### 3.5. Invoicing

| Method | Path                 | Profile | Description                                                      |
| ------ | -------------------- | ------- | ---------------------------------------------------------------- |
| `GET`  | `/api/invoices`      | Free    | Lists the authenticated user's invoices.                         |
| `GET`  | `/api/invoices/{id}` | Free    | Gets details of a specific invoice (public _URL_ from _Moloni_). |

#### 3.5.1. `GET /api/invoices`

**Description:** Lists all invoices of the authenticated user.

**Headers:** `Authorization: Bearer <jwt>`

**Response (200 OK):**

```json
{
  "success": true,
  "data": [
    {
      "id": 1,
      "purchaseId": 456,
      "pdfUrl": "https://moloni.pt/invoice/abc123.pdf",
      "issuedAt": "2026-08-22T12:00:00Z",
      "amount": 9.99
    }
  ]
}
```

#### 3.5.2. `GET /api/invoices/{id}`

**Description:** Gets details of a specific invoice.

**Headers:** `Authorization: Bearer <jwt>`

**Response (200 OK):**

```json
{
  "success": true,
  "data": {
    "id": 1,
    "purchaseId": 456,
    "moloniDocumentId": "doc_789",
    "pdfUrl": "https://moloni.pt/invoice/abc123.pdf",
    "issuedAt": "2026-08-22T12:00:00Z",
    "fiscalData": {
      "name": "John Doe",
      "email": "john@example.com"
    },
    "amount": 9.99,
    "content": "Nutrition Workshop"
  }
}
```

### 3.6. Profile and History

| Method | Path                          | Profile   | Description                                 |
| ------ | ----------------------------- | --------- | ------------------------------------------- |
| `GET`  | `/api/profile`                | Free      | Gets the user's profile data.               |
| `PUT`  | `/api/profile`                | Free      | Updates the user's profile data (name).     |
| `GET`  | `/api/profile/purchases`      | Free      | Lists the user's purchase history.          |
| `GET`  | `/api/profile/weight-history` | _Premium_ | Lists the weight history saved by the user. |
| `POST` | `/api/profile/weight-history` | _Premium_ | Saves a calculator result to the history.   |

#### 3.6.1. `GET /api/profile`

**Description:** Gets the authenticated user's profile data.

**Headers:** `Authorization: Bearer <jwt>`

**Response (200 OK):**

```json
{
  "success": true,
  "data": {
    "id": "550e8400-e29b-41d4-a716-446655440000",
    "email": "user@example.com",
    "name": "John Doe",
    "registeredAt": "2026-08-22T10:00:00Z",
    "lastAccess": "2026-08-22T14:30:00Z"
  }
}
```

#### 3.6.2. `PUT /api/profile`

**Description:** Updates the user's profile data (only the name is editable in the _MVP_).

**Headers:** `Authorization: Bearer <jwt>`

**Request Body:**

```json
{
  "name": "John Peter Doe"
}
```

**Response (200 OK):** Same as `GET /api/profile`.

#### 3.6.3. `GET /api/profile/purchases`

**Description:** Lists the authenticated user's purchase history.

**Headers:** `Authorization: Bearer <jwt>`

**Response (200 OK):**

```json
{
  "success": true,
  "data": [
    {
      "id": 456,
      "contentId": 123,
      "contentTitle": "Nutrition Workshop",
      "amount": 9.99,
      "purchasedAt": "2026-08-22T12:00:00Z",
      "status": "completed"
    }
  ]
}
```

#### 3.6.4. `POST /api/profile/weight-history`

**Description:** Saves a calculator result to the history (requires _premium_ access).

**Headers:** `Authorization: Bearer <jwt>`

**Request Body:**

```json
{
  "breedId": 1,
  "age": 6,
  "currentWeight": 8.2,
  "result": {
    "weight": 8.5,
    "percentile": 50,
    "recommendations": "High-protein diet..."
  }
}
```

**Response (201 Created):**

```json
{
  "success": true,
  "data": {
    "id": 1,
    "recordedAt": "2026-08-22T14:30:00Z"
  }
}
```

**Response (403 Forbidden):**

```json
{
  "success": false,
  "message": "Premium access required to save history"
}
```

## 4. Interaction Flows

The interaction flows between the _frontend_ and the _backend_ are described in the sequence diagrams (document [09_UML_DIAGRAMS.md](09_UML_DIAGRAMS.md)). The main flows are:

### 4.1. _Magic Link_ Authentication

1. User enters email in the _frontend_.
2. _Frontend_ calls `POST /api/auth/magic-link`.
3. _Backend_ generates _token_, stores it in the database, and sends the email via _SendGrid_.
4. User clicks the received link.
5. _Frontend_ calls `GET /api/auth/verify?token=...`.
6. _Backend_ validates the _token_, creates JWT session, and returns the _token_.
7. _Frontend_ stores the JWT in `localStorage` and redirects the user.

### 4.2. Content Access

1. Authenticated user attempts to access content.
2. _Frontend_ calls `GET /api/contents/{id}/access` with JWT.
3. _Backend_ verifies access:
   - Direct purchase with `status = 'completed'` → access granted.
   - Content included in an acquired bundle → access granted.
   - Otherwise → access denied (content locked).
4. _Backend_ returns `hasAccess: true/false`.

### 4.3. _Premium_ Content Purchase with _Stripe_

1. Authenticated user clicks "Buy".
2. _Frontend_ calls `POST /api/payments/create-checkout`.
3. _Backend_ creates a session on _Stripe_ and returns the redirect _URL_.
4. _Frontend_ redirects the user to _Stripe_.
5. User makes the payment.
6. _Stripe_ sends a _webhook_ to `POST /api/payments/webhook`.
7. _Backend_ validates the _webhook_, records the purchase, and generates an invoice via _Moloni_.
8. In parallel, the _frontend_ polls `GET /api/payments/status/{purchaseId}`.
9. When `status = 'completed'`, the _frontend_ unlocks the content.

### 4.4. Hotel Search on Map

1. Authenticated user searches for hotels (by text or "Near Me").
2. _Frontend_ calls `GET /api/maps/geocode` (for text search) or obtains location via _geolocator_.
3. _Frontend_ calls `GET /api/maps/hotels` with coordinates and _viewport_.
4. _Backend_ checks the _cache_:
   - _Cache hit_ → returns cached data.
   - _Cache miss_ → queries _Overpass API_, stores in _cache_, returns data.
5. _Frontend_ displays the hotels as markers on the map.

## 5. Conclusion

The presented specification covers all the flows identified in the sequence diagrams and functional requirements of _The Doghouse_, from authentication to hotel search on the map and _premium_ content purchases. The _endpoints_ respect the profile separation (public, free, and _premium_) and are aligned with the architecture defined in document [07_ARCHITECTURE.md](07_ARCHITECTURE.md).

This documentation will serve as a direct guide for implementing the routes in the _Go_ _backend_ and for testing with tools such as _Postman_ or `curl`.

**Final note:** During the implementation phase, the _endpoints_ and interaction flows may undergo adjustments and refinements to respond to unforeseen needs or improvements identified during development. This document should be updated whenever significant changes occur, ensuring that the documentation remains consistent with the final implementation.
