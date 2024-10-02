// import { handleCategoryVisibility } from './handleCategoryVisibility';
// import { handleOtherFieldVisibility } from './handleOtherFieldVisibility';
// import { handleEssentialTypeVisibility} from './handleEssentialTypeVisibility';

// export function handleCategoryChange(selectElement, otherElement) {
//   if (!selectElement || !selectElement.value) {
//     console.error("Select element is undefined or does not have a value.");
//     return;
//   }
//   console.log("Category changed to:", selectElement.value);
  
//   const selectedValue = selectElement.value;

//   // Mapping for category-specific fields
//   const categoryFields = {
//     'plant': ['species', 'style', 'stage', 'material', 'shape', 'color', 'origin', 'size'],
//     'container': ['material', 'shape', 'color', 'origin', 'size'],
//     'essential': ['essential_type', 'wire', 'tool', 'brand', 'condition']
//   };

//   if (selectElement.id === 'item_category_type') {
//     handleCategoryVisibility(selectedValue, categoryFields);
//   }

//   if (selectElement.id === 'item_essential_type') {
//     handleEssentialTypeVisibility(selectedValue);
//   }

//   // Handle "Other" field visibility using the new module
//   handleOtherFieldVisibility(selectElement, otherElement);
// }
