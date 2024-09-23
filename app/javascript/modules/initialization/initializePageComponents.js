import { initializeCountdown } from './initializeCountdown';
import { initializePriceVisibility } from './initializePriceVisibility';
import { initializeTabs } from './initializeTabs';
import { toggleVisibility } from '../visibility/toggleVisibility';
// import { initializeCategorySelection } from '../visibility/initializeCategorySelection';

export function initializePageComponents() {
  // Initialize countdowns
  initializeCountdown();

  // Initialize price visibility for "Buy it Now" and "Reserve Price"
  initializePriceVisibility('enable_buy_it_now', 'buy_it_now_price_field');
  initializePriceVisibility('enable_reserve_price', 'reserve_price_field');

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
