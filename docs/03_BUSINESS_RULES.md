# Business Rules – The Doghouse

These rules constrain the first-version product. They are grounded in the [frozen decisions in the interview annex](INTERVIEW_ANNEX.md) and the [Scope](01_SCOPE.md). Flows that illustrate them are in [02_PERSONAS_AND_FLOWS.md](02_PERSONAS_AND_FLOWS.md).

## 1. Product and brand

1. The public product name is **The Doghouse**. No other brands or professional identities are mixed into the site, app, or public project documents.
2. Primary audience: **dog owners**. The product is not operations software for clinics, shelters, or breeders.
3. Language for user-facing content: **English** only in the first version.

## 2. Access levels

4. Access ladder: visitor (site + articles) → free member → member who paid for something. There is **no** in-product admin panel in v1; content is placed directly (files or database).
5. There is **no global “premium everything” status**. A paying member only unlocks what they purchased.
6. Free content for all **signed-in** members includes: the free calculator, the free workshops at launch, and the hotels map/list.
7. **Signed-in** members (free or paying) may move from the site to the members’ area without signing in again. Visitors who are not signed in must sign in.

## 3. Authentication

8. Sign-in is simple: email magic link and/or Google or Facebook (exact mix in design). Traditional email-and-password is not required for v1.
9. Magic links are short-lived and single-use; after expiry or use, the user requests a new one.

## 4. Commerce and content

10. The business sells workshops and premium content. Buyers **keep access** to what they paid for. **No monthly subscription** in the first version.
11. Workshops at launch: **2 free** and **4 paid**, **organised by breed**.
12. The full calculator is available only to who paid for it; the free version remains useful without payment.
13. Receipt/invoice is **in for v1**, starting in **trial/test mode** if safer; moving to fully live invoicing is a separate later step.
14. A failed or abandoned payment must not unlock content or create a successful-looking invoice.

## 5. Hotels map

15. Hotels are available to signed-in members to attract and help dog owners (near them or a searched place).
16. Geolocation only after explicit consent; text search remains available if consent is declined.
17. When caching external hotel data, treat results as time-bounded (indicative TTL on the order of a day) and refresh when stale.
18. Map queries should respect the visible area (viewport) rather than dumping an unbounded global list in one call.

## 6. Platform and operations

19. One **shared product** and codebase for phone, computer browser, and installable web app; app-store publication is in scope for v1.
20. The repository is **public**; secrets, passwords, keys, and people’s private data stay out of it.
21. No article comments, in-product social network features, or live support chat in v1.
22. No expensive custom domain required at the start; prefer low ongoing cost while still being able to sell.
23. Advanced visit analytics are not required in v1; contacts are handled when the author can.

## 7. Privacy and trust

24. Use secure connections and careful handling of emails and payment details from day one (serious minimum; detail in design and implementation).
