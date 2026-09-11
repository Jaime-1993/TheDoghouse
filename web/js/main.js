/*
 * The Doghouse – menu toggle + temporary Sign In / hero CTA handlers.
 */

document.addEventListener("DOMContentLoaded", function () {
  // Contract for tests: .menu-toggle ↔ nav.open + .active + aria-expanded
  const toggle = document.querySelector(".menu-toggle");
  const nav = document.querySelector("nav");

  if (toggle && nav) {
    function setMenuOpen(isOpen) {
      nav.classList.toggle("open", isOpen);
      toggle.classList.toggle("active", isOpen);
      toggle.setAttribute("aria-expanded", isOpen ? "true" : "false");
    }

    function closeMenu() {
      setMenuOpen(false);
    }

    toggle.addEventListener("click", function () {
      setMenuOpen(!nav.classList.contains("open"));
    });

    nav.querySelectorAll("a").forEach(function (link) {
      link.addEventListener("click", closeMenu);
    });

    document.addEventListener("keydown", function (e) {
      if (e.key !== "Escape" || !nav.classList.contains("open")) {
        return;
      }
      closeMenu();
      toggle.focus();
    });

    // Close if Tab moves focus out of the header while the panel is open
    const header = toggle.closest("header");
    if (header) {
      header.addEventListener("focusout", function () {
        if (!nav.classList.contains("open")) {
          return;
        }
        // focusout runs before the next focus target is set
        requestAnimationFrame(function () {
          if (
            nav.classList.contains("open") &&
            !header.contains(document.activeElement)
          ) {
            closeMenu();
          }
        });
      });
    }
  }

  // Keep href="/app" in HTML (RF07/RF08); preventDefault is temporary until auth
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
