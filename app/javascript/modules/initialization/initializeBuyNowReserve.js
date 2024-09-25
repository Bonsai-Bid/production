
export function initializeBuyNowReserve(checkboxId, priceFieldId) {
  const checkbox = document.getElementById(checkboxId);
  const priceField = document.getElementById(priceFieldId);

  if (checkbox && priceField) {
    toggleVisibility(checkbox, priceField);
  }
}
