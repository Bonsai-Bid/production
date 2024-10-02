// // app/javascript/modules/initializeAttributes.js
// import { handleCategoryChange } from '../visibility/handleCategoryChange';

// export function initializeAttributes() {
//   const categoryTypeSelect = document.getElementById('item_category_type');
//   const essentialTypeSelect = document.getElementById('item_essential_type');

//   if (categoryTypeSelect) {
//     categoryTypeSelect.addEventListener('change', (event) => {
//       const otherElement = document.getElementById('item_category_type_other');
//       handleCategoryChange(event.target, otherElement);
//     });
//     // Initialize on page load
//     handleCategoryChange(categoryTypeSelect, document.getElementById('item_category_type_other'));
//   }

//   if (essentialTypeSelect) {
//     essentialTypeSelect.addEventListener('change', (event) => {
//       const otherElement = document.getElementById('item_essential_type_other');
//       handleCategoryChange(event.target, otherElement);
//     });
//   }
// }