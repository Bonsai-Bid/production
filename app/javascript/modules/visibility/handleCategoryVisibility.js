// import { handleEssentialTypeVisibility} from './handleEssentialTypeVisibility';



export function handleCategoryVisibility(selectedCategory) {
  console.log("Handling visibility for category:", selectedCategory);

  const categoryFieldsMapping = {
    'plant': ['species', 'style', 'stage', 'material', 'shape', 'color', 'origin', 'size'],
    'container': ['material', 'shape', 'color', 'origin', 'size'],
    'essential': ['essential_type', 'wire', 'tool', 'brand', 'condition']
  };

  const allFieldIds = ['species', 'style', 'stage', 'material', 'shape', 'color', 'origin', 'size', 'essential_type', 'wire', 'tool', 'brand', 'condition'];

  // Hide all fields initially
  allFieldIds.forEach(fieldId => {
    const field = document.getElementById(`item_${fieldId}`);
    if (field) {
      field.classList.add('hidden');
      field.required = false;
    }
  });

  // Show the relevant fields based on the selected category
  if (categoryFieldsMapping[selectedCategory]) {
    categoryFieldsMapping[selectedCategory].forEach(fieldId => {
      const field = document.getElementById(`item_${fieldId}`);
      if (field) {
        console.log(`Showing field: ${fieldId}`);
        field.classList.remove('hidden');
        field.required = true;
      }
    });
  } else {
    console.log("No fields to show for selected category:", selectedCategory);
  }
}
