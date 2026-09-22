(() => {
  if (document.getElementById("brave-mobile-ext-smoke")) return;

  const badge = document.createElement("div");
  badge.id = "brave-mobile-ext-smoke";
  badge.textContent = "EXT";
  badge.title = "Brave mobile extension runtime is active";

  Object.assign(badge.style, {
    position: "fixed",
    right: "8px",
    bottom: "8px",
    zIndex: "2147483647",
    padding: "5px 7px",
    borderRadius: "7px",
    background: "rgba(20, 20, 20, 0.88)",
    color: "white",
    font: "600 11px system-ui, sans-serif",
    pointerEvents: "none",
  });

  document.documentElement.appendChild(badge);
})();
