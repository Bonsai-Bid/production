export function handleCategoryVisibility(selectedCategory) {
  console.log("Handling visibility for category:", selectedCategory);

  const categoryFieldsMapping = {
    'plant': ['species', 'style', 'stage', 'material', 'shape', 'color', 'origin', 'size'],
    'container': ['material', 'shape', 'color', 'origin', 'size'],
    'essential': ['essential_type', 'wire', 'tool', 'brand', 'condition']
  };

  const allFieldIds = ['species', 'style', 'stage', 'material', 'shape', 'color', 'origin', 'size', 'essential_type', 'wire', 'tool', 'brand', 'condition'];

  // Reset visibility and required status for all fields first
  allFieldIds.forEach(fieldId => {
    const field = document.getElementById(`item_${fieldId}`);
    console.log(`Hiding field: ${fieldId}`);
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
        console.log(`Showing field: ${fieldId}`);

        field.classList.remove('hidden');
        field.required = true;
      }
    });
  }
}
