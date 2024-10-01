export function handleOtherFieldVisibility(selectElement, otherElement) {
  const showOtherValues = ['material_other', 'shape_other', 'color_other', 'size_other', 'origin_other', 'essential_other', 'wire_other', 'tool_other', 'species_other', 'style_other', 'stage_other'];
  
  if (otherElement) {
    showOtherFieldVisibility(selectElement.value, otherElement, showOtherValues);
  }
}

// Reusable toggle logic for "Other" fields
function showOtherFieldVisibility(selectedValue, otherElement, showOtherValues) {
  otherElement.classList.toggle('hidden', !showOtherValues.includes(selectedValue));
  otherElement.required = showOtherValues.includes(selectedValue);
}