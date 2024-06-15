document.addEventListener('turbolinks:load', () => {
  const initializeAttributes = () => {
    const itemSpeciesSelect = document.getElementById('item_species');
    const itemSpeciesOther = document.getElementById('item_species_other');
    const itemStyleSelect = document.getElementById('item_style');
    const itemStyleOther = document.getElementById('item_style_other');
    const itemMaterialSelect = document.getElementById('item_material_container');
    const itemMaterialOther = document.getElementById('item_material_container_other');
    const itemShapeSelect = document.getElementById('item_shape_container');
    const itemShapeOther = document.getElementById('item_shape_container_other');
    const itemColorSelect = document.getElementById('item_color_container');
    const itemColorOther = document.getElementById('item_color_container_other');
    const itemOriginSelect = document.getElementById('item_origin_container');
    const itemOriginOther = document.getElementById('item_origin_container_other');
    const itemEssentialTypeSelect = document.getElementById('item_essential_type');
    const itemEssentialOther = document.getElementById('item_essential_other');
    const wireFields = document.getElementById('wire_fields');
    const itemWireTypeSelect = document.getElementById('item_wire_type');
    const itemWireOther = document.getElementById('item_wire_other');
    const toolsFields = document.getElementById('tools_fields');
    const itemToolTypeSelect = document.getElementById('item_tool_type');
    const itemToolOther = document.getElementById('item_tool_other');
    const itemSizeSelect = document.getElementById('item_size_container');
    const itemSizeOther = document.getElementById('item_size_container_other');

    const preselectDropdown = (selectElement, hiddenElement, values) => {
      const selectedValue = selectElement.value;
      hiddenElement.classList.toggle('hidden', !values.includes(selectedValue));
    };

    if (itemSpeciesSelect) {
      preselectDropdown(itemSpeciesSelect, itemSpeciesOther, ['14', 'azalea']);
      itemSpeciesSelect.addEventListener('change', () => {
        preselectDropdown(itemSpeciesSelect, itemSpeciesOther, ['14', 'azalea']);
      });
    }

    if (itemStyleSelect) {
      preselectDropdown(itemStyleSelect, itemStyleOther, ['7', 'cascade']);
      itemStyleSelect.addEventListener('change', () => {
        preselectDropdown(itemStyleSelect, itemStyleOther, ['7', 'cascade']);
      });
    }

    if (itemMaterialSelect) {
      preselectDropdown(itemMaterialSelect, itemMaterialOther, ['4', 'commercial']);
      itemMaterialSelect.addEventListener('change', () => {
        preselectDropdown(itemMaterialSelect, itemMaterialOther, ['4', 'commercial']);
      });
    }

    if (itemShapeSelect) {
      preselectDropdown(itemShapeSelect, itemShapeOther, ['7', 'lotus']);
      itemShapeSelect.addEventListener('change', () => {
        preselectDropdown(itemShapeSelect, itemShapeOther, ['7', 'lotus']);
      });
    }

    if (itemColorSelect) {
      preselectDropdown(itemColorSelect, itemColorOther, ['6', 'blue']);
      itemColorSelect.addEventListener('change', () => {
        preselectDropdown(itemColorSelect, itemColorOther, ['6', 'blue']);
      });
    }

    if (itemOriginSelect) {
      preselectDropdown(itemOriginSelect, itemOriginOther, ['4', 'china']);
      itemOriginSelect.addEventListener('change', () => {
        preselectDropdown(itemOriginSelect, itemOriginOther, ['4', 'china']);
      });
    }

    if (itemEssentialTypeSelect) {
      const checkEssentialType = () => {
        const selectedEssentialType = itemEssentialTypeSelect.value;
        wireFields.classList.add('hidden');
        toolsFields.classList.add('hidden');

        if (selectedEssentialType === '7' || selectedEssentialType === 'wire') {
          wireFields.classList.remove('hidden');
        } else if (selectedEssentialType === '6' || selectedEssentialType === 'tools') {
          toolsFields.classList.remove('hidden');
        }

        itemEssentialOther.classList.toggle('hidden', selectedEssentialType !== '8' && selectedEssentialType !== 'other');
      };

      checkEssentialType();
      itemEssentialTypeSelect.addEventListener('change', checkEssentialType);
    }

    if (itemWireTypeSelect) {
      preselectDropdown(itemWireTypeSelect, itemWireOther, ['3', 'other']);
      itemWireTypeSelect.addEventListener('change', () => {
        preselectDropdown(itemWireTypeSelect, itemWireOther, ['3', 'other']);
      });
    }

    if (itemToolTypeSelect) {
      preselectDropdown(itemToolTypeSelect, itemToolOther, ['6', 'other']);
      itemToolTypeSelect.addEventListener('change', () => {
        preselectDropdown(itemToolTypeSelect, itemToolOther, ['6', 'other']);
      });
    }

    if (itemSizeSelect) {
      preselectDropdown(itemSizeSelect, itemSizeOther, ['7', 'large']);
      itemSizeSelect.addEventListener('change', () => {
        preselectDropdown(itemSizeSelect, itemSizeOther, ['7', 'large']);
      });
    }
  };

  initializeAttributes();
});
