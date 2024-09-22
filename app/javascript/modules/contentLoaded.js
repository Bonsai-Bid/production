document.addEventListener('turbolinks:load', () => {

  initializeCountdown();

  // Call the function to initialize visibility based on checkboxes
  initializePriceVisibility('enable_buy_it_now', 'buy_it_now_price_field');
  initializePriceVisibility('enable_reserve_price', 'reserve_price_field');
  initializeTabs();
  // For handling category-specific field visibility
  const selectedCategory = document.getElementById('item_category_type').value; // Assuming you're pulling this from a select element

const plantFields = document.getElementById('plant_fields');
const containerFields = document.getElementById('container_fields');
const essentialFields = document.getElementById('essential_fields');

toggleVisibility(selectedCategory === 'plant', [plantFields], [containerFields, essentialFields]);
toggleVisibility(selectedCategory === 'container', [containerFields], [plantFields, essentialFields]);
toggleVisibility(selectedCategory === 'essential', [essentialFields], [plantFields, containerFields]);

// For handling checkbox-based visibility
const buyItNowCheckbox = document.getElementById('enable_buy_it_now');
const buyItNowPriceField = document.getElementById('buy_it_now_price_field');

toggleVisibility(buyItNowCheckbox.checked, [buyItNowPriceField], []);
buyItNowCheckbox.addEventListener('change', () => {
  toggleVisibility(buyItNowCheckbox.checked, [buyItNowPriceField], []);
});
});
