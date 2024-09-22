import { toggleFieldVisibility } from './toggleFieldVisibility';

export function initializeCategorySelection() {
  const itemCategorySelect = document.getElementById('item_category_type');
  const plantFields = document.getElementById('plant_fields');
  const containerFields = document.getElementById('container_fields');
  const essentialFields = document.getElementById('essential_fields');

  const initializeCategory = () => {
    const selectedCategory = itemCategorySelect ? itemCategorySelect.value : null;
    toggleFieldVisibility(selectedCategory, plantFields, containerFields, essentialFields);
  };

  // Initial setup on page load
  initializeCategory();

  // Handle category selection change
  if (itemCategorySelect) {
    itemCategorySelect.addEventListener('change', initializeCategory);
  }
}
