/*
 * The Doghouse – Main JavaScript
 * Basic interactions for the institutional website
 */

// Wait for the DOM to be fully loaded
document.addEventListener("DOMContentLoaded", function () {
  // Get references to interactive elements
  var loginBtn = document.getElementById("loginBtn");
  var ctaBtn = document.getElementById("ctaButton");

  // Sign In button click handler
  if (loginBtn) {
    loginBtn.addEventListener("click", function (e) {
      e.preventDefault();
      alert("Sign in functionality is under development.");
    });
  }

  // Get Started button click handler
  if (ctaBtn) {
    ctaBtn.addEventListener("click", function () {
      alert("Explore The Doghouse features!");
    });
  }

  // Log a message to confirm the script is running
  console.log("The Doghouse website loaded successfully.");
});
