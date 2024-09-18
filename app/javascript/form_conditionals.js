document.addEventListener('turbolinks:load', () => {
  const initializeAttributes = () => {
    const handleSelectChange = (selectElement) => {
      const selectedValue = selectElement.value;

      // Fields for plant
      const speciesField = document.getElementById('item_species');
      const styleField = document.getElementById('item_style');
      const stageField = document.getElementById('item_stage');

      // Fields for container and material
      const materialField = document.getElementById('item_material');
      const shapeField = document.getElementById('item_shape');
      const colorField = document.getElementById('item_color');
      const originField = document.getElementById('item_origin');
      const sizeField = document.getElementById('item_size');

      // "Other" fields
      const materialOtherField = document.getElementById('item_material_other');
      const shapeOtherField = document.getElementById('item_shape_other');
      const colorOtherField = document.getElementById('item_color_other');
      const originOtherField = document.getElementById('item_origin_other');
      const sizeOtherField = document.getElementById('item_size_other');
      const speciesOtherField = document.getElementById('item_species_other');
      const styleOtherField = document.getElementById('item_style_other');
      const essentialOtherField = document.getElementById('item_essential_other');
      const wireOtherField = document.getElementById('item_wire_other');
      const toolOtherField = document.getElementById('item_tool_other');

      // Fields for essential category
      const essentialTypeSelect = document.getElementById('item_essential_type');
      const wireFields = document.getElementById('wire_fields');
      const wireField = document.getElementById('item_wire');
      const toolsFields = document.getElementById('tools_fields');
      const toolField = document.getElementById('item_tool');
      const brandField = document.getElementById('item_brand');
      const conditionField = document.getElementById('item_condition');

      // Set all required fields to false initially
      const allFields = [speciesField, styleField, stageField, materialField, shapeField, colorField, originField, sizeField,
        wireField, toolField, brandField, conditionField, speciesOtherField, styleOtherField, materialOtherField, shapeOtherField,
        colorOtherField, originOtherField, sizeOtherField, essentialOtherField, wireOtherField, toolOtherField];
      allFields.forEach(field => {
        if (field) field.required = false;
      });

      // Hide all fields by default
      if (wireFields) wireFields.classList.add('hidden');
      if (toolsFields) toolsFields.classList.add('hidden');

      // Show fields based on category type
      if (selectedValue === 'plant') {
        if (speciesField) speciesField.required = true;
        if (styleField) styleField.required = true;
        if (stageField) stageField.required = true;
        if (materialField) materialField.required = true;
        if (shapeField) shapeField.required = true;
        if (colorField) colorField.required = true;
        if (originField) originField.required = true;
        if (sizeField) sizeField.required = true;
      } else if (selectedValue === 'container') {
        if (materialField) materialField.required = true;
        if (shapeField) shapeField.required = true;
        if (colorField) colorField.required = true;
        if (originField) originField.required = true;
        if (sizeField) sizeField.required = true;
      } else if (selectedValue === 'essential') {
        if (essentialTypeSelect.value === 'wire') {
          if (wireFields) wireFields.classList.remove('hidden');
          if (wireField) wireField.required = true;
        } else if (essentialTypeSelect.value === 'tools') {
          if (toolsFields) toolsFields.classList.remove('hidden');
          if (toolField) toolField.required = true;
          if (brandField) brandField.required = true;
          if (conditionField) conditionField.required = true;
        }
      }

      // Handle "Other" fields visibility and required attributes
      const otherFieldsToCheck = [
        { select: materialField, other: materialOtherField, value: 'material_other' },
        { select: shapeField, other: shapeOtherField, value: 'shape_other' },
        { select: colorField, other: colorOtherField, value: 'color_other' },
        { select: originField, other: originOtherField, value: 'origin_other' },
        { select: sizeField, other: sizeOtherField, value: 'size_other' },
        { select: speciesField, other: speciesOtherField, value: 'species_other' },
        { select: styleField, other: styleOtherField, value: 'style_other' },
        { select: wireField, other: wireOtherField, value: 'wire_other' },
        { select: toolField, other: toolOtherField, value: 'tool_other' },
        { select: essentialTypeSelect, other: essentialOtherField, value: 'essential_other' }
      ];

      otherFieldsToCheck.forEach(({ select, other, value }) => {
        if (select && other) {
          if (select.value === value) {
            other.classList.remove('hidden');
            other.required = true;
          } else {
            other.classList.add('hidden');
            other.required = false;
            other.value = ''; // Clear the value of hidden field
          }
        }
      });
    };

    
    // Handle the category type selection
    const categoryTypeSelect = document.getElementById('item_category_type');
    if (categoryTypeSelect) {
      categoryTypeSelect.addEventListener('change', () => handleSelectChange(categoryTypeSelect));
      handleSelectChange(categoryTypeSelect); // Call this on load to initialize the correct visibility
    }

    // Handle essential type field
    const essentialTypeSelect = document.getElementById('item_essential_type');
    if (essentialTypeSelect) {
      essentialTypeSelect.addEventListener('change', () => handleSelectChange(categoryTypeSelect));  // Ensure this triggers the main category handler
      handleSelectChange(categoryTypeSelect); // Call this on load to initialize the correct visibility
    }
  };

  initializeAttributes();
});
