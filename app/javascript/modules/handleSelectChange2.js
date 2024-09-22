import { clearFormFields } from './clearFormFields';

export function handleSelectChange(selectElement, otherElement) {
  const selectedValue = selectElement.value;
  console.log(`Selected value for ${selectElement.id}: ${selectedValue}`);

  const showOther = [
    'material_other', 'shape_other', 'color_other', 'size_other',
    'origin_other', 'essential_other', 'wire_other', 'tool_other',
    'species_other', 'style_other', 'stage_other'
  ].includes(selectedValue);

  if (showOther && otherElement) {
    console.log(`Showing other field for ${selectElement.id}`);
    otherElement.classList.remove('hidden');
    otherElement.removeAttribute('aria-hidden');
  } else if (otherElement) {
    console.log(`Hiding other field for ${selectElement.id}`);
    otherElement.classList.add('hidden');
    otherElement.setAttribute('aria-hidden', 'true');
    otherElement.value = ''; // Clear value of the hidden field
  }

  // Handle "Essential" category-specific fields
  if (selectElement.id === 'item_essential_type') {
    const wireFields = document.getElementById('wire_fields');
    const toolsFields = document.getElementById('tools_fields');

    if (selectedValue === 'wire') {
      wireFields?.classList.remove('hidden');
      toolsFields?.classList.add('hidden');
      clearFormFields(toolsFields);
    } else if (selectedValue === 'tools') {
      toolsFields?.classList.remove('hidden');
      wireFields?.classList.add('hidden');
      clearFormFields(wireFields);
    } else {
      wireFields?.classList.add('hidden');
      toolsFields?.classList.add('hidden');
      clearFormFields(wireFields);
      clearFormFields(toolsFields);
    }
  }
}
