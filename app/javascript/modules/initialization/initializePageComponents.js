import { initializeCountdown } from "./initializeCountdown";
import { initializeBuyNowReserve } from "./initializeBuyNowReserve";
import { initializeTabs } from "./initializeTabs";

export function initializePageComponents() {
  // Initialize countdowns
  initializeCountdown();

  // Initialize price visibility for "Buy it Now" and "Reserve Price"
  initializeBuyNowReserve('enable_buy_it_now', 'buy_it_now_price_field');
  initializeBuyNowReserve('enable_reserve_price', 'reserve_price_field');

  // Initialize tabs
  initializeTabs();

  // Category-specific visibility handling
  const selectedCategory = document.getElementById('item_category_type')?.value;

  const plantFields = document.getElementById('plant_fields');
  const containerFields = document.getElementById('container_fields');
  const essentialFields = document.getElementById('essential_fields');

  if (selectedCategory) {
    toggleVisibility(selectedCategory === 'plant', [plantFields], [containerFields, essentialFields]);
    toggleVisibility(selectedCategory === 'container', [containerFields], [plantFields, essentialFields]);
    toggleVisibility(selectedCategory === 'essential', [essentialFields], [plantFields, containerFields]);
  }

  // Checkbox-based visibility handling for "Buy it Now"
  const buyItNowCheckbox = document.getElementById('enable_buy_it_now');
  const buyItNowPriceField = document.getElementById('buy_it_now_price_field');

  if (buyItNowCheckbox) {
    toggleVisibility(buyItNowCheckbox.checked, [buyItNowPriceField], []);
    buyItNowCheckbox.addEventListener('change', () => {
      toggleVisibility(buyItNowCheckbox.checked, [buyItNowPriceField], []);
    });
  }
}
