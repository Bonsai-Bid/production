// const categoryFields = {
//   'plant': ['species', 'style', 'stage', 'material', 'shape', 'color', 'origin', 'size'],
//   'container': ['material', 'shape', 'color', 'origin', 'size'],
//   'essential': ['essential_type', 'wire', 'tool', 'brand', 'condition']
// };

// export function handleCategoryVisibility(selectedCategory) {
//   console.log("Handling visibility for category:", selectedCategory);
  
//   const allFields = ['plant_fields', 'container_fields', 'essential_fields'];
  
//   // Hide all fields first
//   allFields.forEach(fieldId => {
//     const field = document.getElementById(fieldId);
//     if (field) {
//       field.classList.add('hidden');
//     }
//   });

//   // Show relevant fields based on selected category
//   if (selectedCategory in categoryFields) {
//     const categoryContainer = document.getElementById(`${selectedCategory}_fields`);
//     if (categoryContainer) {
//       categoryContainer.classList.remove('hidden');
      
//       // Show all direct child divs of the category container
//       categoryContainer.querySelectorAll(':scope > div').forEach(div => {
//         div.classList.remove('hidden');
//       });
//     }
//   }
// }
