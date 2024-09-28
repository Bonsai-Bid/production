import { handleCategoryChange } from './handleCategoryChange'; // Existing function

export function initializeCategorySelect(categorySelect) {
  console.log("Category select initialized:", categorySelect);
  if (categorySelect && categorySelect.value) {
    categorySelect.addEventListener('change', () => handleCategoryChange(categorySelect));
    handleCategoryChange(categorySelect); // Initialize visibility logic on page load
  } else {
    console.log("Category select is not yet set.");
  }
}
