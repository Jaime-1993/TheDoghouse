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
    // One place to open/close — keeps classes and ARIA in sync
    function setMenuOpen(isOpen) {
      nav.classList.toggle("open", isOpen);
      toggle.classList.toggle("active", isOpen);
      toggle.setAttribute("aria-expanded", isOpen ? "true" : "false");
    }

    function closeMenu() {
      setMenuOpen(false);
    }

    toggle.addEventListener("click", function () {
      const willOpen = !nav.classList.contains("open");
      setMenuOpen(willOpen);
    });

    // Close when a nav link is chosen (mobile UX)
    nav.querySelectorAll("a").forEach(function (link) {
      link.addEventListener("click", function () {
        closeMenu();
      });
    });

    // Escape closes the panel and returns focus to the toggle (keyboard UX)
    document.addEventListener("keydown", function (e) {
      if (e.key !== "Escape" || !nav.classList.contains("open")) {
        return;
      }
      closeMenu();
      toggle.focus();
    });

    // If Tab moves focus outside the header while open, close the panel
    // (avoids a visible open menu with focus already on main content)
    const header = toggle.closest("header");
    if (header) {
      header.addEventListener("focusout", function () {
        if (!nav.classList.contains("open")) {
          return;
        }
        // focusout fires before the next element is focused — check on next frame
        requestAnimationFrame(function () {
          if (!nav.classList.contains("open")) {
            return;
          }
          if (!header.contains(document.activeElement)) {
            closeMenu();
          }
        });
      });
    }
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
