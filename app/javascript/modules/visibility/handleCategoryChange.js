
export function handleCategoryChange(selectElement, otherElement) {
  if (!selectElement || !selectElement.value) {
    console.error("Select element is undefined or does not have a value.");
    return;
  }
  console.log("Select element found, handling category change.");

  const selectedValue = selectElement.value;

  // Mapping for category-specific fields
  const categoryFields = {
    'plant': ['species', 'style', 'stage', 'material', 'shape', 'color', 'origin', 'size'],
    'container': ['material', 'shape', 'color', 'origin', 'size'],
    'essential': [] // Add other fields if needed later
  };

  // Handle essential-specific field visibility
  if (selectElement.id === 'item_essential_type') {
    handleEssentialTypeVisibility(selectedValue);
  }

  // Handle category-specific field visibility
  if (selectElement.id === 'item_category_type') {
    handleCategoryVisibility(selectedValue, categoryFields);
  }

  // Handle "Other" field visibility (e.g., material_other, shape_other)
  if (otherElement) {
    const showOtherValues = ['material_other', 'shape_other', 'color_other', 'size_other', 'origin_other', 'essential_other', 'wire_other', 'tool_other', 'species_other', 'style_other', 'stage_other'];
    showOtherFieldVisibility(selectedValue, otherElement, showOtherValues);
  }
}

// Reusable toggle logic for "Other" fields
function showOtherFieldVisibility(selectedValue, otherElement, showOtherValues) {
  otherElement.classList.toggle('hidden', !showOtherValues.includes(selectedValue));
  otherElement.required = showOtherValues.includes(selectedValue);
}
