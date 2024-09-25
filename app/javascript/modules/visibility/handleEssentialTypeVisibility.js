// Handles essential type-specific visibility logic
export function handleEssentialTypeVisibility(selectedValue) {
  const wireFields = document.getElementById('wire_fields');
  const toolsFields = document.getElementById('tools_fields');
  const wire = document.getElementById('item_wire');
  const tool = document.getElementById('item_tool');
  const brand = document.getElementById('item_brand');
  const condition = document.getElementById('item_condition');

  if (selectedValue === 'wire') {
    wireFields.classList.remove('hidden');
    toolsFields.classList.add('hidden');
    wire.required = true;
  } else if (selectedValue === 'tools') {
    toolsFields.classList.remove('hidden');
    wireFields.classList.add('hidden');
    tool.required = true;
    brand.required = true;
    condition.required = true;
  } else {
    wireFields.classList.add('hidden');
    toolsFields.classList.add('hidden');
  }
}