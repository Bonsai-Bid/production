document.addEventListener('turbolinks:load', () => {
  const initializeAttributes = () => {
    const handleSelectChange = (selectElement, otherElement) => {
      const selectedValue = selectElement.value;
      console.log(`Selected value for ${selectElement.id}: ${selectedValue}`);
      const showOther = (
        selectedValue === 'material_other' ||
        selectedValue === 'shape_other' ||
        selectedValue === 'color_other' ||
        selectedValue === 'size_other' ||
        selectedValue === 'origin_other' ||
        selectedValue === 'essential_other' ||
        selectedValue === 'wire_other' ||
        selectedValue === 'tool_other' ||
        selectedValue === 'species_other' ||
        selectedValue === 'style_other' ||
        selectedValue === 'stage_other'
      );

      if (showOther && otherElement) {
        console.log(`Showing other field for ${selectElement.id}`);
        otherElement.classList.remove('hidden');
        otherElement.removeAttribute('aria-hidden');
        console.log(`Other field classes after showing: ${otherElement.className}`);
      } else if (otherElement) {
        console.log(`Hiding other field for ${selectElement.id}`);
        otherElement.classList.add('hidden');
        otherElement.setAttribute('aria-hidden', 'true');
        console.log(`Other field classes after hiding: ${otherElement.className}`);
      }
    };

    const setupSelect = (selectElement, otherElement) => {
      // Add an empty option if not already present
      if (!Array.from(selectElement.options).some(option => option.value === "")) {
        const emptyOption = document.createElement("option");
        emptyOption.value = "";
        emptyOption.text = "";
        selectElement.insertBefore(emptyOption, selectElement.firstChild);
        console.log(`Added empty option to ${selectElement.id}`);
      }

      // Set initial value
      const selectedValue = selectElement.dataset.selectedValue || '';
      selectElement.value = selectedValue;
      console.log(`Initial selected value for ${selectElement.id}: ${selectedValue}`);

      // Ensure correct initial visibility of the "Other" field
      handleSelectChange(selectElement, otherElement);

      // Add event listener for changes
      selectElement.addEventListener('change', () => {
        handleSelectChange(selectElement, otherElement);
      });
    };

    const selectElements = document.querySelectorAll('select[id^="item_"]');
    selectElements.forEach(selectElement => {
      let otherElementId = null;

      if (selectElement.id.endsWith('material')) {
        otherElementId = 'item_material_other';
      } else if (selectElement.id.endsWith('shape')) {
        otherElementId = 'item_shape_other';
      } else if (selectElement.id.endsWith('color')) {
        otherElementId = 'item_color_other';
      } else if (selectElement.id.endsWith('size')) {
        otherElementId = 'item_size_other';
      } else if (selectElement.id.endsWith('origin')) {
        otherElementId = 'item_origin_other';
      } else if (selectElement.id.endsWith('essential_type')) {
        otherElementId = 'item_essential_other';
      } else if (selectElement.id.endsWith('wire_type')) {
        otherElementId = 'item_wire_other';
      } else if (selectElement.id.endsWith('tool_type')) {
        otherElementId = 'item_tool_other';
      } else if (selectElement.id.endsWith('species')) {
        otherElementId = 'item_species_other';
      } else if (selectElement.id.endsWith('style')) {
        otherElementId = 'item_style_other';
      } else if (selectElement.id.endsWith('stage')) {
        otherElementId = 'item_stage_other';
      }

      const otherElement = document.getElementById(otherElementId);
      if (otherElement) {
        console.log(`Setting up ${selectElement.id} with other field ${otherElementId}`);
      } else {
        console.log(`No other field found for ${selectElement.id}`);
      }
      setupSelect(selectElement, otherElement);
    });

    // Add event listener for form reset
    document.querySelectorAll('form').forEach(form => {
      form.addEventListener('reset', () => {
        setTimeout(() => {
          selectElements.forEach(selectElement => {
            let otherElementId = null;

            if (selectElement.id.endsWith('material')) {
              otherElementId = 'item_material_other';
            } else if (selectElement.id.endsWith('shape_container')) {
              otherElementId = 'item_shape_container_other';
            } else if (selectElement.id.endsWith('color_container')) {
              otherElementId = 'item_color_container_other';
            } else if (selectElement.id.endsWith('size_container')) {
              otherElementId = 'item_size_container_other';
            } else if (selectElement.id.endsWith('origin_container')) {
              otherElementId = 'item_origin_container_other';
            } else if (selectElement.id.endsWith('essential_type')) {
              otherElementId = 'item_essential_other';
            } else if (selectElement.id.endsWith('wire_type')) {
              otherElementId = 'item_wire_other';
            } else if (selectElement.id.endsWith('tool_type')) {
              otherElementId = 'item_tool_other';
            } else if (selectElement.id.endsWith('species')) {
              otherElementId = 'item_species_other';
            } else if (selectElement.id.endsWith('style')) {
              otherElementId = 'item_style_other';
            } else if (selectElement.id.endsWith('stage')) {
              otherElementId = 'item_stage_other';
            }

            const otherElement = document.getElementById(otherElementId);
            handleSelectChange(selectElement, otherElement);
          });
        }, 0); // Delay to allow form reset to complete
      });
    });
  };

  initializeAttributes();
});
