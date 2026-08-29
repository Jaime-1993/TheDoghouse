import { readFileSync } from "node:fs";
import { fileURLToPath } from "node:url";
import { dirname, join } from "node:path";
import { describe, it, expect } from "vitest";
import { JSDOM } from "jsdom";

const __dirname = dirname(fileURLToPath(import.meta.url));

const indexHtml = readFileSync(join(__dirname, "../index.html"), "utf8");
const blogHtml = readFileSync(join(__dirname, "../blog.html"), "utf8");
const mainJs = readFileSync(join(__dirname, "../js/main.js"), "utf8");

function loadPage(html) {
  const dom = new JSDOM(html, {
    runScripts: "dangerously",
    url: "http://localhost/",
  });

  const { window } = dom;
  window.alert = () => {};
  window.eval(mainJs);

  // Trigger DOMContentLoaded manually since it may have already fired
  const event = new window.Event("DOMContentLoaded", {
    bubbles: true,
    cancelable: true,
  });
  window.document.dispatchEvent(event);

  return {
    window,
    document: window.document,
  };
}

describe("The Doghouse website", () => {
  it("loads the landing page without crashing", () => {
    const { document } = loadPage(indexHtml);

    expect(document.querySelector("main")).not.toBeNull();
    expect(document.querySelector("h1")?.textContent).toContain(
      "Your perfect companion",
    );
    expect(document.querySelector("nav")).not.toBeNull();
  });

  it("toggles the mobile menu correctly", () => {
    const { document } = loadPage(indexHtml);

    const toggle = document.querySelector(".menu-toggle");
    const nav = document.querySelector("nav");

    expect(toggle).not.toBeNull();
    expect(nav).not.toBeNull();

    toggle.click();

    expect(toggle.classList.contains("active")).toBe(true);
    expect(toggle.getAttribute("aria-expanded")).toBe("true");
    expect(nav.classList.contains("open")).toBe(true);

    toggle.click();

    expect(toggle.classList.contains("active")).toBe(false);
    expect(toggle.getAttribute("aria-expanded")).toBe("false");
  });

  it("contains the required navigation links", () => {
    const { document } = loadPage(indexHtml);

    const links = [...document.querySelectorAll("nav a")].map((a) =>
      a.textContent.trim(),
    );

    expect(links).toEqual(
      expect.arrayContaining([
        "Calculator",
        "Workshops",
        "Hotels",
        "Blog",
        "Sign In",
      ]),
    );
  });

  it("clicking CTA buttons does not throw", () => {
    const { document } = loadPage(indexHtml);

    const ctaHero = document.getElementById("ctaHero");
    const loginBtn = document.getElementById("loginBtn");

    expect(ctaHero).not.toBeNull();
    expect(loginBtn).not.toBeNull();

    expect(() => ctaHero.click()).not.toThrow();
    expect(() => loginBtn.click()).not.toThrow();
  });

  it("loads the blog page with article content", () => {
    const { document } = loadPage(blogHtml);

    expect(document.querySelector("h1")?.textContent).toContain("Blog");
    expect(document.querySelectorAll("article").length).toBeGreaterThan(0);
  });
});
