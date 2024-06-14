// app/javascript/category_initialization.js

document.addEventListener('turbolinks:load', () => {
  const itemCategorySelect = document.getElementById('item_category_type');
  const plantFields = document.getElementById('plant_fields');
  const containerFields = document.getElementById('container_fields');
  const essentialFields = document.getElementById('essential_fields');

  const initializeCategory = () => {
    const selectedCategory = itemCategorySelect ? itemCategorySelect.value : null;

    if (plantFields) plantFields.classList.add('hidden');
    if (containerFields) containerFields.classList.add('hidden');
    if (essentialFields) essentialFields.classList.add('hidden');

    if (selectedCategory === '3') {
      if (plantFields) plantFields.classList.remove('hidden');
      if (containerFields) containerFields.classList.remove('hidden');
    } else if (selectedCategory === '1') {
      if (containerFields) containerFields.classList.remove('hidden');
    } else if (selectedCategory === '2') {
      if (essentialFields) essentialFields.classList.remove('hidden');
    }
  };

  // Initial setup on page load
  initializeCategory();

  // Handle category selection change
  if (itemCategorySelect) {
    itemCategorySelect.addEventListener('change', initializeCategory);
  }
});
