export function handleSelectChange(selectElement, otherElement) {
  const selectedValue = selectElement.value;
  console.log(`Selected value for ${selectElement.id}: ${selectedValue}`);

  const fields = {
    species: document.getElementById('item_species'),
    style: document.getElementById('item_style'),
    stage: document.getElementById('item_stage'),
    material: document.getElementById('item_material'),
    shape: document.getElementById('item_shape'),
    color: document.getElementById('item_color'),
    origin: document.getElementById('item_origin'),
    size: document.getElementById('item_size'),
    essentialType: document.getElementById('item_essential_type'),
    wireFields: document.getElementById('wire_fields'),
    wire: document.getElementById('item_wire'),
    toolsFields: document.getElementById('tools_fields'),
    tool: document.getElementById('item_tool'),
    brand: document.getElementById('item_brand'),
    condition: document.getElementById('item_condition')
  };

  const otherFields = {
    material: document.getElementById('item_material_other'),
    shape: document.getElementById('item_shape_other'),
    color: document.getElementById('item_color_other'),
    origin: document.getElementById('item_origin_other'),
    size: document.getElementById('item_size_other'),
    species: document.getElementById('item_species_other'),
    style: document.getElementById('item_style_other'),
    essential: document.getElementById('item_essential_other'),
    wire: document.getElementById('item_wire_other'),
    tool: document.getElementById('item_tool_other')
  };

  // Reset all fields
  Object.values(fields).forEach(field => {
    if (field) field.required = false;
  });
  Object.values(otherFields).forEach(field => {
    if (field) {
      field.classList.add('hidden');
      field.required = false;
      field.value = '';
    }
  });

  // Handle "Other" fields
  const showOtherValues = [
    'material_other', 'shape_other', 'color_other', 'size_other',
    'origin_other', 'essential_other', 'wire_other', 'tool_other',
    'species_other', 'style_other', 'stage_other'
  ];

  if (showOtherValues.includes(selectedValue) && otherElement) {
    otherElement.classList.remove('hidden');
    otherElement.removeAttribute('aria-hidden');
    otherElement.required = true;
  }

  // Handle category-specific fields
  if (selectElement.id === 'item_category_type') {
    const categoryFields = {
      'plant': ['species', 'style', 'stage', 'material', 'shape', 'color', 'origin', 'size'],
      'container': ['material', 'shape', 'color', 'origin', 'size'],
      'essential': []
    };

    if (categoryFields[selectedValue]) {
      categoryFields[selectedValue].forEach(fieldName => {
        if (fields[fieldName]) fields[fieldName].required = true;
      });
    }
  }

  // Handle essential type
  if (selectElement.id === 'item_essential_type') {
    if (selectedValue === 'wire') {
      fields.wireFields.classList.remove('hidden');
      fields.toolsFields.classList.add('hidden');
      fields.wire.required = true;
    } else if (selectedValue === 'tools') {
      fields.toolsFields.classList.remove('hidden');
      fields.wireFields.classList.add('hidden');
      fields.tool.required = true;
      fields.brand.required = true;
      fields.condition.required = true;
    } else {
      fields.wireFields.classList.add('hidden');
      fields.toolsFields.classList.add('hidden');
    }
  }
}
