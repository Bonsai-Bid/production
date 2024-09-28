import { handleCategoryChange } from './handleCategoryChange'; // Existing function

export function initializeCategorySelect(categorySelect) {
  console.log("Category select initialized:", categorySelect);
  categorySelect.addEventListener('change', () => handleCategoryChange(categorySelect));
  handleCategoryChange(categorySelect); // Initialize visibility logic on page load
}
