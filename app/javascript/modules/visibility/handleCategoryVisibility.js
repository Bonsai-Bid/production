export function handleCategoryVisibility(selectedCategory) {
  const categoryFieldsMapping = {
    'plant': ['species', 'style', 'stage', 'material', 'shape', 'color', 'origin', 'size'],
    'container': ['material', 'shape', 'color', 'origin', 'size'],
    'essential': ['wire', 'tool', 'brand', 'condition']
  };

  const allFieldIds = ['species', 'style', 'stage', 'material', 'shape', 'color', 'origin', 'size', 'wire', 'tool', 'brand', 'condition'];

  // Reset visibility and required status for all fields first
  allFieldIds.forEach(fieldId => {
    const field = document.getElementById(`item_${fieldId}`);
    if (field) {
      field.classList.add('hidden');
      field.required = false;
    }
  });

  // Show and mark relevant fields as required based on the selected category
  if (categoryFieldsMapping[selectedCategory]) {
    categoryFieldsMapping[selectedCategory].forEach(fieldId => {
      const field = document.getElementById(`item_${fieldId}`);
      if (field) {
        field.classList.remove('hidden');
        field.required = true;
      }
    });
  }
}
