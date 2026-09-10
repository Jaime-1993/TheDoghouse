/*
 * The Doghouse – main UI script
 * Menu toggle + placeholder Sign In / hero CTA until auth ships.
 */

document.addEventListener("DOMContentLoaded", function () {
  // ===== Hamburger menu =====
  // Contract: .menu-toggle ↔ nav.open + .active + aria-expanded
  const toggle = document.querySelector(".menu-toggle");
  const nav = document.querySelector("nav");

  if (toggle && nav) {
    toggle.addEventListener("click", function () {
      const isOpen = nav.classList.toggle("open");
      toggle.classList.toggle("active");
      toggle.setAttribute("aria-expanded", isOpen);
    });

    // Close the panel when a nav link is chosen (mobile UX)
    nav.querySelectorAll("a").forEach(function (link) {
      link.addEventListener("click", function () {
        nav.classList.remove("open");
        toggle.classList.remove("active");
        toggle.setAttribute("aria-expanded", "false");
      });
    });
  }

  // ===== Placeholders (keep until real auth / flows exist) =====
  // #loginBtn keeps href="/app" in HTML (RF07/RF08); preventDefault is temporary.
  const loginBtn = document.getElementById("loginBtn");
  if (loginBtn) {
    loginBtn.addEventListener("click", function (e) {
      e.preventDefault();
      alert("Sign in functionality is under development.");
    });
  }

  const ctaHero = document.getElementById("ctaHero");
  if (ctaHero) {
    ctaHero.addEventListener("click", function (e) {
      e.preventDefault();
      alert("Explore The Doghouse features!");
    });
  }
});
