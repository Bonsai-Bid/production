// export function handleSelectChange(selectElement, otherElement) {
//   const selectedValue = selectElement.value;

//   // Mapping for category-specific fields
//   const categoryFields = {
//     'plant': ['species', 'style', 'stage', 'material', 'shape', 'color', 'origin', 'size'],
//     'container': ['material', 'shape', 'color', 'origin', 'size'],
//     'essential': []
//   };

//   // "Other" fields visibility handling
//   const showOtherValues = [
//     'material_other', 'shape_other', 'color_other', 'size_other',
//     'origin_other', 'essential_other', 'wire_other', 'tool_other',
//     'species_other', 'style_other', 'stage_other'
//   ];

//   // Reset all fields' required status and hide "Other" fields
//   resetFields(categoryFields);
//   resetOtherFields(otherElement);

//   // Show "Other" fields if applicable
//   if (showOtherValues.includes(selectedValue) && otherElement) {
//     showOtherField(otherElement);
//   }

//   // Handle category-specific field visibility
//   if (selectElement.id === 'item_category_type') {
//     handleCategoryVisibility(selectedValue, categoryFields);
//   }

//   // Handle essential type-specific visibility
//   if (selectElement.id === 'item_essential_type') {
//     handleEssentialTypeVisibility(selectedValue);
//   }
// }
