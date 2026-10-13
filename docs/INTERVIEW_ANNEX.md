# Interview annex – The Doghouse

**Status:** English version — answers in the voice of a non-technical client (product owner).  
**Source questionnaire:** `00_INTERVIEW.md`  
**Who answers:** the idea / business owner (client simulation). How it is built is for the developer in design and implementation.  
**Answers / freeze date (proposal):** 2026-10-13  

---

## Frozen decisions (proposal — client voice)

| ID | Decision |
| -- | -------- |
| **A** | The product is called **The Doghouse**. I want a website that presents the project and a members’ area with useful tools for dog owners. |
| **B** | This is a **real product and a real business** for dog owners — not an abstract exercise. |
| **C** | I decide what is in and out of scope. I do not want other brands or identities mixed into The Doghouse in anything public. |
| **D** | Primary audience: dog owners. I am not building a tool for clinics, shelters, or breeders to run their operations. |
| **E** | Some people only visit, some sign up for free, and some pay for extra content. No panel for me to edit the site/app in the first version — I deliver the content to the developer and they put it into the product. |
| **F** | In the first version I want: site + articles; members’ area on phone, computer browser, and **installable web app** (add to home screen); **one shared product** (same codebase and same experience everywhere); calculator (free and full paid version); workshops (**2 free** and **4 paid** at launch); map / list of pet-friendly hotels to attract people; simple sign-in; moving from the site to the members’ area without signing in again; ability to **sell**, and a receipt/invoice if the business needs it; app available in the app stores. |
| **G** | In the first version I do **not** want: comments on articles; social features inside the product (likes, followers, profiles); live support chat; languages other than English. |
| **H** | I want to start with low costs. I do not need an expensive custom domain at the start. I am fine if payments and invoices begin in a trial/test mode if the developer says that is safer — the business goal is still to **make money** from workshops and paid content. |
| **I** | I want to **sell** workshops and premium content. Buyers keep access to what they paid for (I am not thinking about a monthly subscription in the first version). |
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
**Answer:** It is a **real product** for dog owners and a business. I hired technical help because I am not a developer; what matters to me is that it works for people and that I can sell.

**3. Who decides and what must not appear**  
**Question:** Who decides scope changes, who else must be consulted, and is there any brand or identity that must not appear?  
**Answer:** I decide. There is no one else who must be consulted. I do not want other brands or professional “faces” mixed into The Doghouse on the site, in the app, or in the project’s public documents.

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
**Answer:** Visitor (sees the site and articles) → free member → member who paid for something. I do not need a panel to edit everything myself: I deliver the content to the developer and they put it into the product.

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
| Video workshops | **In** | At launch: **2 free** and **4 paid**; organised by breed (or whatever fits the content best) |
| Pet-friendly hotels | **In** | People see relevant places, ideally near them or in a city they search, and can open them in the phone’s maps |
| Account / sign-in | **In** | Simple sign-in: email and/or Google or Facebook — the developer chooses the safest simple option |
| From site to members’ area without signing in again | **In** | Anyone already “in” does not have to sign in again |
| Selling content | **In** | I can charge for workshops / extras |
| Invoice or receipt | **In** | If the business needs it, there is a receipt/invoice — the developer says how at the start (trial vs live) |
| App stores (App Store / Play Store) | **In** | The app is published in the main stores |

**9. Anything else mandatory?**  
**Question:** What else must exist or the project is incomplete?  
**Answer:** It has to be reliable day to day: people sign in, use it, pay, and I can put workshops and content up for sale. Do not ask me for technical lists — I ask that it works and that people’s data is handled carefully.

**10. What I do not want in the first version**  
**Question:** What stays out?  
**Answer:** Comments on articles; a “social network” inside the product; live chat; languages other than English; an expensive custom domain just for show; anything that delays the essentials (selling workshops + useful tools + attracting people with the hotels).

---

### Practical limits

**11. Timeline**  
**Question:** When do you want the first usable version?  
**Answer:** I would like something usable on the order of **two to three months** of work, but I prefer it done well over a rigid date that hurts quality. We agree milestones with the developer.

**12. Money for tools and domain**  
**Question:** Budget for services, cheap plans, custom domain?  
**Answer:** I want to spend as little as possible at the start. Cheap or free plans are fine if the service holds up. A custom domain can wait.

**13. Serious rules from day one**  
**Question:** Privacy, legal, security?  
**Answer:** I do not want nasty surprises with people’s data. Secure connection, care with emails and payment details. The developer covers the serious minimum; I do not recite laws, but I expect privacy to be respected.

**14. Third-party services**  
**Question:** Can you use outside services (payments, email, maps, login)?  
**Answer:** Yes, if they are needed for the business (pay, send sign-in email, maps, sign in with Google, and so on). I do not want shady solutions or copying hotel data from websites illegally — the developer chooses proper sources.

---

### Money, reach, and content

**15. How I make money**  
**Question:** Revenue in the first version? What do you sell? One-time purchase or subscription?  
**Answer:** I want to **make money** selling workshops and premium content. Buyers keep access to what they paid for. I do **not** want a monthly subscription in the first version. If some payments start in test mode for safety, that is fine — the goal is still to sell for real.

**16. Where people find me**  
**Question:** External channels? Ideal next step? Marketing emails?  
**Answer:** The idea comes from someone who already has or wants a presence on social media. The ideal path: someone sees me on social media → comes to the site → reads → creates an account → uses or buys. In the first version I do **not** need marketing newsletters; emails only for signing in or purchase-related matters.

**17. What I already have**  
**Question:** Logos, texts, videos, data? Who creates what is missing?  
**Answer:** I bring animal knowledge and I create the content (texts, workshop videos, and so on). I hand them to the developer to put into the product. Logos and missing materials we sort out as the project goes. I do not want to copy other sites’ look or text.

**18. Public work on the internet**  
**Question:** Can the repository / work be public?  
**Answer:** Yes — the repository is **public** (code and documentation). Passwords, keys, and people’s data must **not** be exposed there. I do not manage that day to day.

---

### After going public

**19. Who maintains it and statistics**  
**Question:** Who updates content and answers people? Do you need statistics?  
**Answer:** I keep creating and delivering content to the developer, as I already said — I do not need a panel to put it in myself. I answer contacts when I can. In the first version I do not ask for advanced visit statistics.

**20. Worries, must-haves, can wait**  
**Question:** What worries you; what you will not give up; what can wait; did the questionnaire miss anything?  
**Answer:**

- I worry about: the project growing too big; not being able to sell; content (videos) running late; the thing being hard to use.
- I will not give up what I asked for in the first version (site, members’ area, workshops to sell, calculator, hotels to bring people in, simple sign-in, phone, computer, installable web, same experience everywhere).
- What can wait is what I already said stays out (comments, social network in the product, chat, other languages, custom domain at the start, newsletters, fancy statistics).
- If something was missing: pet-friendly hotels are really there to bring people to the site — that is part of the business, not a side extra.

---

## Open points (TBD)

These stay open for the developer to propose or choose in the design (unless noted):

- Workshop / package **prices** (exact amounts) — client still to set.  
- Exact **sign-in method** mix (email and/or Google / Facebook) — developer chooses the safest simple option.  
- Legal / proper **source of hotel data** — developer chooses (no illegal copying).  
- Payments and invoices: **trial/test mode vs live** at launch — developer proposes what is safe first.  
- Whether the **2–3 month** horizon becomes firm milestones — agree with the developer.  
- Turning “success” stories (Q7) into **measurable** checks in the Scope — for the Scope document, not for this annex.

---

## Closing

These answers are the **client’s**: what I want and why. How it is done is for the developer in the design, aligned with this. Learning or portfolio goals on the developer’s side, if any, belong in the Scope — not in this annex.
