// document.addEventListener('turbolinks:load', () => {
//   const initializeAttributes = () => {
//     const itemSpeciesSelect = document.getElementById('item_species');
//     const itemSpeciesOther = document.getElementById('item_species_other');
//     const itemStyleSelect = document.getElementById('item_style');
//     const itemStyleOther = document.getElementById('item_style_other');
//     const itemMaterialSelect = document.getElementById('item_material_container');
//     const itemMaterialOther = document.getElementById('item_material_container_other');
//     const itemShapeSelect = document.getElementById('item_shape_container');
//     const itemShapeOther = document.getElementById('item_shape_container_other');
//     const itemColorSelect = document.getElementById('item_color_container');
//     const itemColorOther = document.getElementById('item_color_container_other');
//     const itemOriginSelect = document.getElementById('item_origin_container');
//     const itemOriginOther = document.getElementById('item_origin_container_other');
//     const itemEssentialTypeSelect = document.getElementById('item_essential_type');
//     const itemEssentialOther = document.getElementById('item_essential_other');
//     const wireFields = document.getElementById('wire_fields');
//     const itemWireTypeSelect = document.getElementById('item_wire_type');
//     const itemWireOther = document.getElementById('item_wire_other');
//     const toolsFields = document.getElementById('tools_fields');
//     const itemToolTypeSelect = document.getElementById('item_tool_type');
//     const itemToolOther = document.getElementById('item_tool_other');
//     const itemSizeSelect = document.getElementById('item_size_container');
//     const itemSizeOther = document.getElementById('item_size_container_other');

//     if (itemSpeciesSelect) {
//       itemSpeciesSelect.addEventListener('change', () => {
//         if (itemSpeciesOther) itemSpeciesOther.classList.toggle('hidden', itemSpeciesSelect.value !== '14');
//       });
//     }

//     if (itemStyleSelect) {
//       itemStyleSelect.addEventListener('change', () => {
//         if (itemStyleOther) itemStyleOther.classList.toggle('hidden', itemStyleSelect.value !== '7');
//       });
//     }

//     if (itemMaterialSelect) {
//       itemMaterialSelect.addEventListener('change', () => {
//         if (itemMaterialOther) itemMaterialOther.classList.toggle('hidden', itemMaterialSelect.value !== '4');
//       });
//     }

//     if (itemShapeSelect) {
//       itemShapeSelect.addEventListener('change', () => {
//         if (itemShapeOther) itemShapeOther.classList.toggle('hidden', itemShapeSelect.value !== '7');
//       });
//     }

//     if (itemColorSelect) {
//       itemColorSelect.addEventListener('change', () => {
//         if (itemColorOther) itemColorOther.classList.toggle('hidden', itemColorSelect.value !== '6');
//       });
//     }

//     if (itemOriginSelect) {
//       itemOriginSelect.addEventListener('change', () => {
//         if (itemOriginOther) itemOriginOther.classList.toggle('hidden', itemOriginSelect.value !== '4');
//       });
//     }

//     if (itemEssentialTypeSelect) {
//       const checkEssentialType = () => {
//         const selectedEssentialType = itemEssentialTypeSelect.value;
//         if (wireFields) wireFields.classList.add('hidden');
//         if (toolsFields) toolsFields.classList.add('hidden');

//         if (selectedEssentialType === '4') {
//           if (wireFields) wireFields.classList.remove('hidden');
//         } else if (selectedEssentialType === '7') {
//           if (toolsFields) toolsFields.classList.remove('hidden');
//         }

//         if (itemEssentialOther) itemEssentialOther.classList.toggle('hidden', selectedEssentialType !== '8');
//       };

//       // Initial check on page load
//       checkEssentialType();

//       itemEssentialTypeSelect.addEventListener('change', checkEssentialType);
//     }

//     if (itemWireTypeSelect) {
//       itemWireTypeSelect.addEventListener('change', () => {
//         if (itemWireOther) itemWireOther.classList.toggle('hidden', itemWireTypeSelect.value !== '3');
//       });
//     }

//     if (itemToolTypeSelect) {
//       itemToolTypeSelect.addEventListener('change', () => {
//         if (itemToolOther) itemToolOther.classList.toggle('hidden', itemToolTypeSelect.value !== '6');
//       });
//     }

//     if (itemSizeSelect) {
//       itemSizeSelect.addEventListener('change', () => {
//         if (itemSizeOther) itemSizeOther.classList.toggle('hidden', itemSizeSelect.value !== '7');
//       });
//     }
//   };

//   initializeAttributes();
// });