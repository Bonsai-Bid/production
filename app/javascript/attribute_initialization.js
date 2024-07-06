document.addEventListener('turbolinks:load', () => {
  const initializeAttributes = () => {
    const handleSelectChange = (selectElement, otherElement) => {
      const selectedValue = selectElement.value;
      console.log(`Selected value for ${selectElement.id}: ${selectedValue}`);

      // Show or hide "Other" fields
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
        otherElement.value = ''; // Clear the value of the hidden field
        console.log(`Other field classes after hiding: ${otherElement.className}`);
      }

      // Show or hide wire and tool fields based on essential_type selection
      if (selectElement.id === 'item_essential_type') {
        const wireFields = document.getElementById('wire_fields');
        const toolsFields = document.getElementById('tools_fields');

        if (selectedValue === 'wire') {
          console.log('Showing wire fields');
          if (wireFields) {
            wireFields.classList.remove('hidden');
            wireFields.removeAttribute('aria-hidden');
          }
          if (toolsFields) {
            toolsFields.classList.add('hidden');
            toolsFields.setAttribute('aria-hidden', 'true');
            clearFormFields(toolsFields); // Clear the values of the hidden fields
          }
        } else if (selectedValue === 'tools') {
          console.log('Showing tools fields');
          if (toolsFields) {
            toolsFields.classList.remove('hidden');
            toolsFields.removeAttribute('aria-hidden');
          }
          if (wireFields) {
            wireFields.classList.add('hidden');
            wireFields.setAttribute('aria-hidden', 'true');
            clearFormFields(wireFields); // Clear the values of the hidden fields
          }
        } else {
          if (wireFields) {
            wireFields.classList.add('hidden');
            wireFields.setAttribute('aria-hidden', 'true');
            clearFormFields(wireFields); // Clear the values of the hidden fields
          }
          if (toolsFields) {
            toolsFields.classList.add('hidden');
            toolsFields.setAttribute('aria-hidden', 'true');
            clearFormFields(toolsFields); // Clear the values of the hidden fields
          }
        }
      }
    };

    const setupSelect = (selectElement, otherElement) => {
      // Set initial value
      const selectedValue = selectElement.dataset.selectedValue || '';
      selectElement.value = selectedValue;
      console.log(`Initial selected value for ${selectElement.id}: ${selectedValue}`);

      // Ensure correct initial visibility of the "Other" field and wire/tools fields
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
      } else if (selectElement.id.endsWith('tool')) {
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
            } else if (selectElement.id.endsWith('wire')) {
              otherElementId = 'item_wire_other';
            } else if (selectElement.id.endsWith('tool')) {
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

  const clearFormFields = (container) => {
    const inputs = container.querySelectorAll('input, select, textarea');
    inputs.forEach(input => {
      input.value = '';
    });
  };

  initializeAttributes();
});
