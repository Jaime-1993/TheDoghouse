# Project Interview – The Doghouse

## 1. Introduction

This document is the structured interview for **The Doghouse**. It turns an early conversation about the product into a short set of questions for a **simulated client** (simulated product owner) to answer in writing. I (the developer) run the interview; the answers are recorded in the interview annex.

The aim is alignment: so that I know what the (simulated) product owner wants, what they do not want, and what “good enough” means. Detail that belongs in later design meetings is left out on purpose. A questionnaire that is too long produces rushed or careless answers; this one is sized for one sitting (about **20–30 minutes**), including the scope checklist in question 8.

In our previous informal talks we already touched on a digital presence around dog care — an institutional website, a member-facing application, and a first version that should be useful while remaining realistic to build. Nothing below assumes those ideas are final. Please confirm, correct, or replace them.

If you do not know yet, write **TBD**. We will resolve TBD items in a short meeting before freezing the scope.

---

## 2. How to complete this interview

1. Answer in order when you can; skip only if a later answer unlocks an earlier one.  
2. Prefer clear choices (“yes / no / later version”) over vague wishes.  
3. Return the answers so they can be recorded in the interview annex (`INTERVIEW_ANNEX.md`) — that file is the official home of your answers and of the frozen decisions that feed the scope.  
4. Expect one short follow-up meeting for TBD items and for the freeze.

This file is the **questionnaire only**. The annex holds the answers.

---

## 3. Questions

### Identity and purpose

1. What should the product be called in the first version, and in one or two sentences what is it for?  
2. Is this first version mainly a **real product for end users**, mainly a **learning / reusable technical skeleton**, or **both**? What balance do you want?  
3. Who decides scope changes, who else must be consulted, and is there any brand or identity that must **not** appear in the public product or docs?  
4. What tone and language(s) should the first version use with users?

### Audience and success

5. Who is the primary user of the first version, who is secondary, and who is explicitly **out of scope**?  
6. What access levels do you need at launch (for example visitor / free member / paying member), and do you need an in-product admin for content — or is content managed outside the app for now?  
7. What problem should The Doghouse solve better than social media or generic sites, and how will you know the first version succeeded (up to five concrete outcomes)? What would count as failure even if some features exist?

### First-version scope

8. Which of these belong in the **first version**? For each, say *in / later / out*, and add a one-line “enough for v1” note where useful:  
   - institutional website  
   - blog  
   - member application  
   - platforms for the app (browser Web, installable Web / *PWA*, iPhone, Android) — and whether all chosen platforms must share the same experience  
   - dog ideal-weight (or similar) calculator (free vs paid depth)  
   - workshops / video lessons (how organised: breed, topic, …)  
   - map of pet-friendly places (what it must do: near me, city search, open in phone maps, …)  
   - account + sign-in (which methods are mandatory)  
   - move from website to app **without signing in again**  
   - buying premium content  
   - invoices / fiscal documents (test environment vs real)  
   - publication on App Store and Play Store  
9. What else **must** be in the first version or the project is incomplete?  
10. What should stay **out** of the first version (including things others might expect — e.g. blog comments, social features, full admin panel, live chat, extra languages)?

### Constraints

11. What is the target calendar for a first usable version, and how firm is it?  
12. What budget limits apply for tools and services, and are free / low-cost plans with limitations acceptable? Do you need a custom domain at launch, or are host subdomains enough?  
13. What legal, privacy (*GDPR* or similar), regional, or security rules are non-negotiable from day one?  
14. Are third-party services allowed (payments, email, maps, login providers)? Any ban list?

### Money, channels, and content

15. In the first version, is revenue required, optional, or only a demonstrated test purchase? What do you sell (if anything), and is access one-time, subscription, or mixed?  
16. Which external channels already exist (social or other), and what should happen when someone discovers you there (ideal next step on the site or in the app)? Do you need email marketing in v1?  
17. What brand assets, texts, media, or data do you already have — and who creates what is missing? Any sources we must use or must not copy?  
18. The project repository is **public** (code and documentation on GitHub). Any exception or limit to that openness?

### After launch and freeze

19. Who updates content and handles user questions after launch? Do you need basic analytics in v1?  
20. What worries you most, what must stay **non-negotiable** for v1 (up to five bullets), and what can wait for a later version (up to five bullets)? Anything important from our informal talks that this questionnaire missed?

---

## 4. After you answer

1. Answers are copied into **`INTERVIEW_ANNEX.md`** (official record).  
2. Frozen decisions are labelled so the scope can cite them without guesswork.  
3. TBD items are scheduled for a short clarification meeting.  
4. Only after the annex matches your intent do we close the interview pack and continue with scope.

If a later meeting changes an answer, we update the annex and note the date — we do not silently overwrite history.

---

## 5. Closing

Twenty focused questions beat a long list that loses attention halfway. Answer honestly, mark TBD where needed, and keep question numbers when you reply. The next step is your written responses, then the annex, then alignment with the scope of the first version.
