

export const initializeAttributes = () => {
  const categoryTypeSelect = document.getElementById('item_category_type');
  const essentialTypeSelect = document.getElementById('item_essential_type');

  if (categoryTypeSelect) {
    categoryTypeSelect.addEventListener('change', () => handleSelectChange(categoryTypeSelect));
    handleSelectChange(categoryTypeSelect); // Initialize on load
  }

  if (essentialTypeSelect) {
    essentialTypeSelect.addEventListener('change', () => handleSelectChange(categoryTypeSelect));
  }
};
