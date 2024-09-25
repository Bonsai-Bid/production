// // app/javascript/form_submission.js

// document.addEventListener('turbolinks:load', () => {
//   const form = document.querySelector('form');

//   if (form) {
//     form.addEventListener('submit', (event) => {
//       const fieldsToConvert = [
//         'item_category_type', 'item_species', 'item_style', 'item_stage',
//         'item_material_container', 'item_shape_container', 'item_color_container',
//         'item_size_container', 'item_origin_container', 'item_essential_type',
//         'item_wire_type', 'item_tool_type'
//       ];

//       fieldsToConvert.forEach(fieldId => {
//         const field = document.getElementById(fieldId);
//         if (field && field.value !== '') {
//           field.value = parseInt(field.value, 10);
//         }
//       });

//       const optionalFields = form.querySelectorAll('input[type="text"], select');
//       optionalFields.forEach(field => {
//         if (field.value === '') {
//           field.disabled = true; 
//         }
//       });
//     });
//   }
// });
