# Interview annex – The Doghouse

**Status:** Answers from a **simulated client** (simulated product owner), in first person.  
**Source questionnaire:** `00_INTERVIEW.md`  
**Who interviewed:** I (the developer who owns this public repository) ran the interview.  
**Who answers:** a **simulated product owner / client**. This annex records their **product** choices (what and why). **How** the system is built, and learning or portfolio aims for this public repository, are my decisions as developer and are stated in the Scope — not as answers from this simulated client.  
**Answers / freeze date (proposal):** 2026-10-13  

---

## Frozen decisions (proposal — simulated product-owner voice)

| ID | Decision |
| -- | -------- |
| **A** | The product is called **The Doghouse**. There is a website that presents the project and a members’ area with useful tools for dog owners. |
| **B** | This is a **real product and a real business** for dog owners — not an abstract exercise. As product owner, I decide product scope. |
| **C** | As product owner, I decide what is in and out of scope. I do not want other brands or professional identities mixed into The Doghouse on the site or in the app. |
| **D** | Primary audience: dog owners. This is not a tool for clinics, shelters, or breeders to run their operations. |
| **E** | Some people only visit, some sign up for free, and some pay for extra content. No in-product admin panel in the first version — content is placed directly into the product (files or database), not through owner-facing edit screens. |
| **F** | In the first version: site + articles; members’ area on phone, computer browser, and **installable web app** (add to home screen); **one shared product** (same codebase and same experience everywhere); calculator (free and full paid version); workshops (**2 free** and **4 paid** at launch), **organised by breed**, with purchase of individual paid videos and **bundles** (by breed, and complete present set of then-existing paid videos — buyers keep **lifetime access** to purchased items; **no** SKU for unpublished future videos); map / list of pet-friendly hotels to attract people; simple sign-in; **signed-in members** (free or paying) move from the site to the members’ area on **Flutter Web** without signing in again (**native** iOS/Android apps authenticate **inside the app**); ability to **sell**; **receipt/invoice is in for v1** (trial/test mode acceptable to the owner); store **publication path** exercised (App Store / Play Store). **Developer freeze (how this public repo operates — not owner voice):** Stripe/Moloni **sandbox** here; Play as download channel; App Store submission best effort — approval does not block the rest of v1; reusers may switch live providers via environment variables. |
| **G** | In the first version I do **not** want: comments on articles; social features inside the product (likes, followers, profiles); live support chat; languages other than English. |
| **H** | Start with low costs. No expensive custom domain at the start. Receipt/invoice in v1 may run in trial/test mode first (see **F**); the business goal is still to **make money** from workshops and paid content. **Developer note:** the owner’s “make money” answer stays as the simulated brief. This **public** repository implements the sell-and-invoice path in **Stripe/Moloni sandbox**. Someone who reuses the skeleton may switch to live providers with their own secrets and environment variables. |
| **I** | **Sell** workshops and premium content. Buyers keep access to what they paid for (no monthly subscription in the first version). **Developer note:** same as **H** — owner wants to sell for real; this public project demonstrates that path in **sandbox**; live operation is a reuse choice via env, not an operating promise of this repo. |
| **J** | The project repository is **public** (code and documentation). Secrets, passwords, keys, and people’s private data stay **out** of that public place. |
| **K** | I answer contacts when I can. In the first version I do not need advanced visit statistics. (Content: see **E**.) |

---

## Answers

### Identity and purpose

**1. Name and what it is for**  
**Question:** What should the product be called in the first version, and in one or two sentences what is it for?  
**Answer:** It is called **The Doghouse**. I want a site where people get to know the project and read articles, and a members’ area with a weight calculator, video workshops, and a place to find dog-friendly hotels — and through that, make money by selling the workshops and extra content.

**2. Real product vs something else**  
**Question:** Is the first version mainly a product for end users, mainly technical learning, or both?  
**Answer:** For this annex it is a **real product and business** for dog owners. What matters here is that the product works for people and that I can sell.

**3. Who decides and what must not appear**  
**Question:** Who decides scope changes, who else must be consulted, and is there any brand or identity that must not appear?  
**Answer:** As product owner, I decide. There is no one else who must be consulted. I do not want other brands or professional “faces” mixed into The Doghouse on the site or in the app.

**4. Tone and language**  
**Question:** What tone and language(s) should the first version use with users?  
**Answer:** A friendly, clear tone — like someone who likes animals, without making it complicated. Everything in **English** (site, app, and user-facing content).

---

### Audience and success

**5. Who uses it**  
**Question:** Primary user, secondary user, and who is out of scope?  
**Answer:**

- Primary: dog owners.
- Secondary: someone who only came to read an article or see what the project is.
- Out of scope: vets using this as a clinic tool, shelters and breeders running their operations — that is not this product.

**6. Access types**  
**Question:** Access levels at launch? Do you need screens to manage all the content?  
**Answer:** Visitor (sees the site and articles) → free member → member who paid for something. No admin panel for me to edit everything in the product — content goes in directly (files or database).

**7. Problem, success, failure**  
**Question:** What problem does it solve? How do you know it went well? What would count as failure?  
**Answer:**

- Problem: knowledge and tips are scattered across social media; I want a stable place with useful tools and workshops I can sell. Pet-friendly hotels also help bring new people to the site.
- Success: someone finds the site, sees the value, creates an account without hassle, uses what is free, buys a workshop, and finds useful hotels on the map — on phone and on computer.
- Failure: something pretty that nobody can use; not being able to sell; a map or workshops that help no one; a confusing or unprofessional message.

---

### First-version scope

**8. What is in / later / out**

| Item | Answer | In plain language, “good enough for v1 if…” |
| ---- | ------ | --------------------------------------------- |
| Site presenting the project | **In** | There is a clear page on what The Doghouse is and a path to the members’ area |
| Articles / blog | **In** | There are articles you can read without an account |
| Members’ area (app) | **In** | There is a calculator, workshops, and map/hotels |
| Phone and computer | **In** | Works on phone (iPhone and Android) and in the computer browser |
| Installable web app (home screen) | **In** | People can install / add the members’ area from the browser |
| Same experience everywhere | **In** | Same product and same codebase on phone, browser, and installable web — not a weaker version on one platform |
| Weight calculator | **In** | A useful free version; the full version only for who paid |
| Video workshops | **In** | At launch: **2 free** and **4 paid**, **organised by breed**; individual paid videos and bundles (breed, complete present). *(Developer: no future-video SKU; lifetime access = to purchased items.)* |
| Pet-friendly hotels | **In** | People see relevant places, ideally near them or in a city they search, and can open them in the phone’s maps |
| Account / sign-in | **In** | Simple sign-in: email and/or Google or Facebook — the exact mix is chosen in design |
| From site to members’ area without signing in again | **In** | **Signed-in members** move from the site to **Flutter Web** without signing in again; **native** apps authenticate **inside the app**; visitors who are not signed in still need to sign in |
| Selling content | **In** | I can charge for workshops / extras |
| Invoice or receipt | **In** | **In for v1**, starting in trial/test mode if safer *(developer: sandbox in this public repo; live via env for reusers)* |
| App stores (App Store / Play Store) | **In** | **Publication path** exercised *(developer freeze: Play as download channel; App Store submission best effort — approval does not block the rest of v1)* |

**9. Anything else mandatory?**  
**Question:** What else must exist or the project is incomplete?  
**Answer:** It has to be reliable day to day: people sign in, use it, pay, and I can put workshops and content up for sale. I ask that it works and that people’s data is handled carefully — not for a technical shopping list in this annex.

**10. What I do not want in the first version**  
**Question:** What stays out?  
**Answer:** Comments on articles; a “social network” inside the product; live chat; languages other than English; an expensive custom domain just for show; anything that delays the essentials (selling workshops + useful tools + attracting people with the hotels).

---

### Practical limits

**11. Timeline**  
**Question:** When do you want the first usable version?  
**Answer:** I would like something usable on the order of **two to three months** of work, but I prefer it done well over a rigid date that hurts quality. *(Owner wish.)* Milestones, as I imagined them, would be set as the work proceeds. *(Developer freeze — supersedes the wish for package planning: week map frozen from S01 = 3 Aug 2026; usable v1 = Deliveries 1–7 ≈ **420 h solo** → **~15 weeks** at 28 h/week or **~20 weeks** at 21 h/week. Two months is not a published package target.)*

**12. Money for tools and domain**  
**Question:** Budget for services, cheap plans, custom domain?  
**Answer:** I want to spend as little as possible at the start. Cheap or free plans are fine if the service holds up. A custom domain can wait.

**13. Serious rules from day one**  
**Question:** Privacy, legal, security?  
**Answer:** I do not want nasty surprises with people’s data. Secure connection, care with emails and payment details. Design and implementation cover the serious minimum; I expect privacy to be respected.

**14. Third-party services**  
**Question:** Can you use outside services (payments, email, maps, login)?  
**Answer:** Yes, if they are needed for the business (pay, send sign-in email, maps, sign in with Google, and so on). No shady solutions and no illegally copying hotel data from other websites — proper sources are chosen in design.

---

### Money, reach, and content

**15. How I make money**  
**Question:** Revenue in the first version? What do you sell? One-time purchase or subscription?  
**Answer:** I want to **make money** selling workshops and premium content. Buyers keep access to what they paid for. I do **not** want a monthly subscription in the first version. Payments may start in test mode for safety; the goal is still to sell for real. Receipt/invoice is in for v1 (see **F**). *(Developer note: owner answer unchanged. This public project runs Stripe/Moloni in **sandbox**. Reusers may enable live mode with their own secrets — see **H**/**I** and the [business rules](03_BUSINESS_RULES.md).)*

**16. Where people find me**  
**Question:** External channels? Ideal next step? Marketing emails?  
**Answer:** The idea builds on a presence on social media. The ideal path: someone sees the project on social media → comes to the site → reads → creates an account → uses or buys. In the first version I do **not** need marketing newsletters; emails only for signing in or purchase-related matters.

**17. What I already have**  
**Question:** Logos, texts, videos, data? Who creates what is missing?  
**Answer:** I bring animal knowledge and I create the content (texts, workshop videos, and so on). It goes into the product through the implementation (no admin panel). Logos and missing materials we sort out as the project goes. I do not want to copy other sites’ look or text.

**18. Public work on the internet**  
**Question:** Can the repository / work be public?  
**Answer:** Yes — the repository is **public** (code and documentation). Passwords, keys, and people’s data must **not** be exposed there.

---

### After going public

**19. Who maintains it and statistics**  
**Question:** Who updates content and answers people? Do you need statistics?  
**Answer:** I keep creating content and placing it into the product as in **E** — no admin panel. I answer contacts when I can. In the first version I do not ask for advanced visit statistics.

**20. Worries, must-haves, can wait**  
**Question:** What worries you; what you will not give up; what can wait; did the questionnaire miss anything?  
**Answer:**

- I worry about: the project growing too big; not being able to sell; content (videos) running late; the thing being hard to use.
- I will not give up what I asked for in the first version (site, members’ area, workshops by breed to sell, calculator, hotels to bring people in, simple sign-in, phone, computer, installable web, same experience everywhere, receipt/invoice in v1).
- What can wait is what I already said stays out (comments, social network in the product, chat, other languages, custom domain at the start, newsletters, fancy statistics). *(Developer note: live banking / fiscal invoicing is not an operating goal of this public simulation; sandbox is the default here.)*
- If something was missing: pet-friendly hotels are really there to bring people to the site — that is part of the business, not a side extra.

---

## Open points (TBD)

These stay open for design and implementation (unless noted):

- Workshop / package **prices** — **resolved** for v1 in the [business rules](03_BUSINESS_RULES.md) (EUR catalogue; developer freeze).  
- Exact **sign-in method** mix (magic link and/or Google and/or Facebook) — both social providers remain in scope; exact enabled mix may still be configured in implementation.  
- Legal / proper **source of hotel data** — Overpass with pet-friendly tags is the chosen approach in Scope / Personas / business rules (no illegal copying).  
- Moving this public project’s operated commerce from **sandbox** to live banking / fiscal invoicing — **closed for this repository**: stay on **sandbox**. The simulated owner’s “make money” intent (**H**, **I**, Q15) remains as interview fiction. Reusers of the skeleton may configure live Stripe/Moloni with their own secrets and environment variables.  
- Week milestones for the proposal calendar — **closed** in the schedule (S01 = 3 Aug 2026 through S29); usable-v1 horizon — **closed** in Scope / schedule / proposal report (~420 h solo ÷ weekly rate).  
- Turning “success” stories (Q7) into **measurable** checks — the Scope already states flow-level measurable criteria; refine further in design if needed.

---

## Closing

These answers are **product decisions from a simulated client / simulated product owner**: what the product is and why. I (the developer) ran the interview and I decide how it is built, plus any learning or portfolio aims for this public repository — that sits in the Scope, next to these product choices.
