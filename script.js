
const menuBtn = document.getElementById("menuBtn");
const navMenu = document.getElementById("navMenu");

// Mobile navigation
menuBtn.addEventListener("click", () => {
  const isOpen = navMenu.classList.toggle("open");
  menuBtn.setAttribute("aria-expanded", String(isOpen));
  menuBtn.textContent = isOpen ? "✕" : "☰";
});

// Close navigation after clicking a link
navMenu.querySelectorAll("a").forEach((link) => {
  link.addEventListener("click", () => {
    navMenu.classList.remove("open");
    menuBtn.setAttribute("aria-expanded", "false");
    menuBtn.textContent = "☰";
  });
});

// Automatically update copyright year
document.getElementById("year").textContent =
  new Date().getFullYear();
