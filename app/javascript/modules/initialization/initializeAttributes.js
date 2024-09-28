import { handleSelectChange } from "../visibility/handleSelectChange";

export const initializeAttributes = () => {
  const categoryTypeSelect = document.getElementById('item_category_type');
  const essentialTypeSelect = document.getElementById('item_essential_type');
  console.log("Category select initialized:", categoryTypeSelect);

  if (categoryTypeSelect) {
    categoryTypeSelect.addEventListener('change', () => handleSelectChange(categoryTypeSelect));
    console.log("Category changed to:", categoryTypeSelect.value);

    handleSelectChange(categoryTypeSelect); // Initialize on load
  }

  if (essentialTypeSelect) {
    essentialTypeSelect.addEventListener('change', () => handleSelectChange(categoryTypeSelect));
  }
};
