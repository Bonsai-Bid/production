import { toggleVisibility } from './toggleVisibility'; // Assuming you have this utility

export function initializePriceVisibility(checkboxId, priceFieldId) {
  const checkbox = document.getElementById(checkboxId);
  const priceField = document.getElementById(priceFieldId);

  if (checkbox && priceField) {
    toggleVisibility(checkbox, priceField);
  }
}
