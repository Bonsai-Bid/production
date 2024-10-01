import { handleCategoryChange } from './handleCategoryChange'; // Existing function

export function initializeCategorySelect(categorySelect) {
  // console.log("Category select initialized:", categorySelect);
  if (categorySelect) {
    // console.log("Category select value on load:", categorySelect.value || "No value selected");

    categorySelect.addEventListener('change', () => {
      // console.log("Category changed to:", categorySelect.value);
      handleCategoryChange(categorySelect);
    });
  } else {
    console.log("Category select is not yet set.");
  }
}
