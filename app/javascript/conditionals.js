// document.addEventListener('turbolinks:load', () => {
//   const initializeFormAttributes = () => {
//     // Utility function to clear input fields
//     const clearFormFields = (container) => {
//       const inputs = container?.querySelectorAll('input, select, textarea');
//       inputs?.forEach(input => {
//         input.value = '';
//         input.required = false;
//       });
//     };

//     // Function to handle changes in select elements
//     const handleSelectChange = (selectElement, otherElement) => {
//       const selectedValue = selectElement.value;
//       console.log(`Selected value for ${selectElement.id}: ${selectedValue}`);

//       // Show or hide "Other" fields based on selected value
//       const showOtherValues = [
//         'material_other', 'shape_other', 'color_other', 'size_other',
//         'origin_other', 'essential_other', 'wire_other', 'tool_other',
//         'species_other', 'style_other', 'stage_other'
//       ];

//       if (showOtherValues.includes(selectedValue) && otherElement) {
//         console.log(`Showing other field for ${selectElement.id}`);
//         otherElement.classList.remove('hidden');
//         otherElement.removeAttribute('aria-hidden');
//         otherElement.required = true;
//       } else if (otherElement) {
//         console.log(`Hiding other field for ${selectElement.id}`);
//         otherElement.classList.add('hidden');
//         otherElement.setAttribute('aria-hidden', 'true');
//         otherElement.value = ''; // Clear value of the hidden field
//         otherElement.required = false;
//       }

//       // Specific handling for 'item_essential_type'
//       if (selectElement.id === 'item_essential_type') {
//         const wireFields = document.getElementById('wire_fields');
//         const toolsFields = document.getElementById('tools_fields');

//         if (selectedValue === 'wire') {
//           wireFields?.classList.remove('hidden');
//           toolsFields?.classList.add('hidden');
//           clearFormFields(toolsFields);
//           // Set required attributes
//           document.getElementById('item_wire')?.setAttribute('required', true);
//         } else if (selectedValue === 'tools') {
//           toolsFields?.classList.remove('hidden');
//           wireFields?.classList.add('hidden');
//           clearFormFields(wireFields);
//           // Set required attributes
//           document.getElementById('item_tool')?.setAttribute('required', true);
//           document.getElementById('item_brand')?.setAttribute('required', true);
//           document.getElementById('item_condition')?.setAttribute('required', true);
//         } else {
//           wireFields?.classList.add('hidden');
//           toolsFields?.classList.add('hidden');
//           clearFormFields(wireFields);
//           clearFormFields(toolsFields);
//         }
//       }

//       // Handle category-specific required fields
//       if (selectElement.id === 'item_category_type') {
//         const category = selectedValue;
//         // Define fields based on category
//         const categoryFields = {
//           'plant': ['item_species', 'item_style', 'item_stage', 'item_material', 'item_shape', 'item_color', 'item_origin', 'item_size'],
//           'container': ['item_material', 'item_shape', 'item_color', 'item_origin', 'item_size'],
//           'essential': [] // 'essential' is handled via 'item_essential_type'
//         };

//         // First, clear all category-related required attributes
//         ['item_species', 'item_style', 'item_stage', 'item_material', 'item_shape', 'item_color', 'item_origin', 'item_size'].forEach(fieldId => {
//           const field = document.getElementById(fieldId);
//           if (field && field !== selectElement) {
//             field.required = false;
//           }
//         });

//         // Set required attributes based on selected category
//         if (categoryFields[category]) {
//           categoryFields[category].forEach(fieldId => {
//             const field = document.getElementById(fieldId);
//             if (field) {
//               field.required = true;
//             }
//           });
//         }
//       }
//     };

//     // Function to setup event listeners on select elements
//     const setupSelect = (selectElement, otherElement) => {
//       const initialSelectedValue = selectElement.value;
//       handleSelectChange(selectElement, otherElement);

//       selectElement.addEventListener('change', () => {
//         handleSelectChange(selectElement, otherElement);
//       });
//     };

//     // Initialize all select elements that start with 'item_'
//     const selectElements = document.querySelectorAll('select[id^="item_"]');
//     selectElements.forEach(selectElement => {
//       const otherElementId = `item_${selectElement.id.split('_').slice(1).join('_')}_other`;
//       const otherElement = document.getElementById(otherElementId);
//       setupSelect(selectElement, otherElement);
//     });

//     // Handle form reset to re-initialize required attributes and visibility
//     document.querySelectorAll('form').forEach(form => {
//       form.addEventListener('reset', () => {
//         setTimeout(() => {
//           selectElements.forEach(selectElement => {
//             const otherElementId = `item_${selectElement.id.split('_').slice(1).join('_')}_other`;
//             const otherElement = document.getElementById(otherElementId);
//             handleSelectChange(selectElement, otherElement);
//           });
//         }, 0); // Delay to allow form reset to complete
//       });
//     });
//   };

//   initializeFormAttributes();
// });
