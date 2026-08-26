/*
 * The Doghouse – Main JavaScript
 * Handles navigation, UI interactions, and user feedback
 */

// Wait for the DOM to be fully loaded before binding events
document.addEventListener("DOMContentLoaded", function () {
  // ===== Hamburger Menu =====
  const toggle = document.querySelector(".menu-toggle");
  const nav = document.querySelector("nav");

  if (toggle && nav) {
    // Toggle navigation visibility on button click
    toggle.addEventListener("click", function () {
      const isOpen = nav.classList.toggle("open");
      toggle.classList.toggle("active");
      toggle.setAttribute("aria-expanded", isOpen);
    });

    // Close menu when a link is clicked (improves mobile UX)
    nav.querySelectorAll("a").forEach(function (link) {
      link.addEventListener("click", function () {
        nav.classList.remove("open");
        toggle.classList.remove("active");
        toggle.setAttribute("aria-expanded", "false");
      });
    });
  }

  // ===== Interactive Elements =====
  const loginBtn = document.getElementById("loginBtn");
  const ctaBtn = document.getElementById("ctaButton");
  const ctaHero = document.getElementById("ctaHero");

  // Sign In button handler
  if (loginBtn) {
    loginBtn.addEventListener("click", function (e) {
      e.preventDefault();
      alert("Sign in functionality is under development.");
    });
  }

  // Hero section "Get started" button handler
  if (ctaHero) {
    ctaHero.addEventListener("click", function (e) {
      e.preventDefault();
      alert("Explore The Doghouse features!");
    });
  }

  // Fallback for any other "Get started" buttons
  if (ctaBtn) {
    ctaBtn.addEventListener("click", function () {
      alert("Explore The Doghouse features!");
    });
  }

  // Confirm script execution in the console
  console.log("The Doghouse website loaded successfully.");
});
