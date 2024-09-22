import { convertFieldsToInt } from './convertFieldsToInt';
import { disableEmptyFields } from './disableEmptyFields';

export function initializeFormSubmission() {
  const form = document.querySelector('form');

  if (form) {
    form.addEventListener('submit', (event) => {
      const fieldsToConvert = [
        'item_category_type', 'item_species', 'item_style', 'item_stage',
        'item_material_container', 'item_shape_container', 'item_color_container',
        'item_size_container', 'item_origin_container', 'item_essential_type',
        'item_wire_type', 'item_tool_type'
      ];

      // Convert the selected fields to integers
      convertFieldsToInt(fieldsToConvert);

      // Disable empty fields
      disableEmptyFields(form);
    });
  }
}
