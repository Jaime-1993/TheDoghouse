# Unit Tests – The Doghouse Institutional Website

## Overview

This directory contains unit tests for The Doghouse institutional website static assets (HTML, CSS, JavaScript). The tests validate the core functionality of the site without requiring a live browser or external dependencies.

## Purpose

The unit tests ensure that:

- The website loads without runtime errors
- The mobile menu toggles correctly with proper state management
- Navigation links are present and accessible
- Call-to-action (CTA) buttons do not throw exceptions when clicked
- The blog page loads with expected content structure

## Testing Stack

- **Vitest** — fast unit test runner optimized for ES modules
- **jsdom** — JavaScript implementation of the DOM (Web APIs) for Node.js
- **Node.js** — runtime environment

## Running Tests

From the `web/` directory:

```bash
npm test
```

This executes all tests in `tests/site.spec.js` and reports results in the terminal.

To watch for file changes and re-run tests:

```bash
npx vitest
```

## Test Coverage

| Test                                     | Purpose                                                      |
| ---------------------------------------- | ------------------------------------------------------------ |
| loads the landing page without crashing  | Validates HTML structure and main content rendering          |
| toggles the mobile menu correctly        | Verifies hamburger menu state management and ARIA attributes |
| contains the required navigation links   | Ensures all primary navigation links are present             |
| clicking CTA buttons does not throw      | Confirms interactive buttons handle clicks without errors    |
| loads the blog page with article content | Validates blog page structure and article presence           |

## Acceptance Criteria

✅ **Criterion: "JavaScript interactions do not break page loading"**

- All five tests pass
- Menu interactions are stable
- No runtime exceptions during user interactions
- DOM remains stable after JavaScript execution

## Notes

- Tests run in a Node.js environment with simulated DOM (jsdom), not in a real browser
- `window.alert()` is mocked in tests to prevent test interruptions
- The `DOMContentLoaded` event is manually triggered to ensure JavaScript bindings execute correctly
