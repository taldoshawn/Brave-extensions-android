const status = document.getElementById("status");
const value = document.getElementById("value");
const button = document.getElementById("count");

async function refresh() {
  const { count = 0 } = await chrome.storage.local.get("count");
  value.textContent = String(count);
  status.textContent = "MV3 popup + storage are working.";
}

button.addEventListener("click", async () => {
  const { count = 0 } = await chrome.storage.local.get("count");
  await chrome.storage.local.set({ count: count + 1 });
  await refresh();
});

refresh().catch((error) => {
  status.textContent = `Error: ${error.message}`;
});
