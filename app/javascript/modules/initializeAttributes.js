import { handleSelectChange } from './handleSelectChange';

export const initializeAttributes = () => {
  // Handle the category type selection
  const categoryTypeSelect = document.getElementById('item_category_type');
  if (categoryTypeSelect) {
    categoryTypeSelect.addEventListener('change', () => handleSelectChange(categoryTypeSelect));
    handleSelectChange(categoryTypeSelect); // Call this on load to initialize the correct visibility
  }

  // Handle essential type field change
  const essentialTypeSelect = document.getElementById('item_essential_type');
  if (essentialTypeSelect) {
    essentialTypeSelect.addEventListener('change', () => handleSelectChange(categoryTypeSelect)); // Trigger main category change
  }
};
