export const handleSelectChange = (selectElement) => {
  const selectedValue = selectElement.value;

  // Field references for plant, container, and material categories
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

  // "Other" fields
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

  // Reset all fields to not required and hide other-specific fields
  Object.values(fields).forEach(field => {
    if (field) field.required = false;
  });
  Object.values(otherFields).forEach(field => {
    if (field) {
      field.classList.add('hidden');
      field.required = false;
      field.value = ''; // Clear the value when hidden
    }
  });

  // Show relevant fields based on category type
  if (selectedValue === 'plant') {
    fields.species.required = true;
    fields.style.required = true;
    fields.stage.required = true;
    fields.material.required = true;
    fields.shape.required = true;
    fields.color.required = true;
    fields.origin.required = true;
    fields.size.required = true;
  } else if (selectedValue === 'container') {
    fields.material.required = true;
    fields.shape.required = true;
    fields.color.required = true;
    fields.origin.required = true;
    fields.size.required = true;
  } else if (selectedValue === 'essential') {
    if (fields.essentialType.value === 'wire') {
      fields.wireFields.classList.remove('hidden');
      fields.wire.required = true;
    } else if (fields.essentialType.value === 'tools') {
      fields.toolsFields.classList.remove('hidden');
      fields.tool.required = true;
      fields.brand.required = true;
      fields.condition.required = true;
    }
  }

  // Handle visibility of "Other" fields
  const otherFieldMappings = [
    { select: fields.material, other: otherFields.material, value: 'material_other' },
    { select: fields.shape, other: otherFields.shape, value: 'shape_other' },
    { select: fields.color, other: otherFields.color, value: 'color_other' },
    { select: fields.origin, other: otherFields.origin, value: 'origin_other' },
    { select: fields.size, other: otherFields.size, value: 'size_other' },
    { select: fields.species, other: otherFields.species, value: 'species_other' },
    { select: fields.style, other: otherFields.style, value: 'style_other' },
    { select: fields.wire, other: otherFields.wire, value: 'wire_other' },
    { select: fields.tool, other: otherFields.tool, value: 'tool_other' },
    { select: fields.essentialType, other: otherFields.essential, value: 'essential_other' }
  ];

  otherFieldMappings.forEach(({ select, other, value }) => {
    if (select && other && select.value === value) {
      other.classList.remove('hidden');
      other.required = true;
    }
  });
};
