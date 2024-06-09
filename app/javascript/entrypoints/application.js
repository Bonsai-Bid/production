import Rails from '@rails/ujs';
import Turbolinks from 'turbolinks';
import * as ActiveStorage from '@rails/activestorage';
import './application.css'; // Using Tailwind CSS file

Rails.start();
Turbolinks.start();
ActiveStorage.start();

document.addEventListener('turbolinks:load', () => {
  const itemCategorySelect = document.getElementById('item_category_type');
  const plantFields = document.getElementById('plant_fields');
  const containerFields = document.getElementById('container_fields');
  const essentialFields = document.getElementById('essential_fields');
  const itemSpeciesSelect = document.getElementById('item_species');
  const itemSpeciesOther = document.getElementById('item_species_other');
  const itemStyleSelect = document.getElementById('item_style');
  const itemStyleOther = document.getElementById('item_style_other');
  const itemMaterialSelect = document.getElementById('item_material_container');
  const itemMaterialOther = document.getElementById('item_material_container_other');
  const itemShapeSelect = document.getElementById('item_shape_container');
  const itemShapeOther = document.getElementById('item_shape_container_other');
  const itemColorSelect = document.getElementById('item_color_container');
  const itemColorOther = document.getElementById('item_color_container_other');
  const itemOriginSelect = document.getElementById('item_origin_container');
  const itemOriginOther = document.getElementById('item_origin_container_other');
  const itemEssentialTypeSelect = document.getElementById('item_essential_type');
  const itemEssentialOther = document.getElementById('item_essential_other');
  const wireFields = document.getElementById('wire_fields');
  const itemWireTypeSelect = document.getElementById('item_wire_type');
  const itemWireOther = document.getElementById('item_wire_other');
  const toolsFields = document.getElementById('tools_fields');
  const itemToolTypeSelect = document.getElementById('item_tool_type');
  const itemToolOther = document.getElementById('item_tool_other');
  const itemSizeSelect = document.getElementById('item_size_container');
  const itemSizeOther = document.getElementById('item_size_container_other');
  const form = document.querySelector('form');

  // Initial setup
  const initializeForm = () => {
    const selectedCategory = itemCategorySelect ? itemCategorySelect.value : null;
    const selectedSpecies = itemSpeciesSelect ? itemSpeciesSelect.value : null;
    const selectedStyle = itemStyleSelect ? itemStyleSelect.value : null;
    const selectedMaterial = itemMaterialSelect ? itemMaterialSelect.value : null;
    const selectedShape = itemShapeSelect ? itemShapeSelect.value : null;
    const selectedColor = itemColorSelect ? itemColorSelect.value : null;
    const selectedOrigin = itemOriginSelect ? itemOriginSelect.value : null;
    const selectedEssentialType = itemEssentialTypeSelect ? itemEssentialTypeSelect.value : null;
    const selectedWireType = itemWireTypeSelect ? itemWireTypeSelect.value : null;
    const selectedToolType = itemToolTypeSelect ? itemToolTypeSelect.value : null;
    const selectedSize = itemSizeSelect ? itemSizeSelect.value : null;

    if (plantFields) plantFields.classList.toggle('hidden', selectedCategory !== '1');
    if (selectedCategory === '1' && containerFields) {
      containerFields.classList.toggle('hidden', false);
    }
    if (containerFields) containerFields.classList.toggle('hidden', selectedCategory !== '2');
    if (essentialFields) essentialFields.classList.toggle('hidden', selectedCategory !== '3');

    if (itemSpeciesOther) itemSpeciesOther.classList.toggle('hidden', selectedSpecies !== '14');
    if (itemStyleOther) itemStyleOther.classList.toggle('hidden', selectedStyle !== '7');
    if (itemMaterialOther) itemMaterialOther.classList.toggle('hidden', selectedMaterial !== '4');
    if (itemShapeOther) itemShapeOther.classList.toggle('hidden', selectedShape !== '7');
    if (itemColorOther) itemColorOther.classList.toggle('hidden', selectedColor !== '6');
    if (itemOriginOther) itemOriginOther.classList.toggle('hidden', selectedOrigin !== '4');
    if (wireFields) wireFields.classList.toggle('hidden', selectedEssentialType !== '4');
    if (toolsFields) toolsFields.classList.toggle('hidden', selectedEssentialType !== '7');
    if (itemEssentialOther) itemEssentialOther.classList.toggle('hidden', selectedEssentialType !== '8');
    if (itemWireOther) itemWireOther.classList.toggle('hidden', selectedWireType !== '3');
    if (itemToolOther) itemToolOther.classList.toggle('hidden', selectedToolType !== '6');
    if (itemSizeOther) itemSizeOther.classList.toggle('hidden', selectedSize !== '7');
  };

  // Run initial setup on page load
  initializeForm();

  // Handle form submission
  if (form) {
    form.addEventListener('submit', (event) => {
      const fieldsToConvert = [
        'item_category_type', 'item_species', 'item_style', 'item_stage',
        'item_material_container', 'item_shape_container', 'item_color_container',
        'item_size_container', 'item_origin_container', 'item_essential_type',
        'item_wire_type', 'item_tool_type'
      ];

      fieldsToConvert.forEach(fieldId => {
        const field = document.getElementById(fieldId);
        if (field && field.value !== '') {
          field.value = parseInt(field.value, 10);
        }
      });

      const optionalFields = form.querySelectorAll('input[type="text"], select');
      optionalFields.forEach(field => {
        if (field.value === '') {
          field.disabled = true; 
        }
      });
    });
  }

  // Handle category selection change
  if (itemCategorySelect) {
    itemCategorySelect.addEventListener('change', () => {
      const selectedCategory = itemCategorySelect.value;
      if (plantFields) plantFields.classList.add('hidden');
      if (containerFields) containerFields.classList.add('hidden');
      if (essentialFields) essentialFields.classList.add('hidden');

      if (selectedCategory === '1') {
        if (plantFields) plantFields.classList.remove('hidden');
        if (containerFields) containerFields.classList.remove('hidden');
      } else if (selectedCategory === '2') {
        if (containerFields) containerFields.classList.remove('hidden');
      } else if (selectedCategory === '3') {
        if (essentialFields) essentialFields.classList.remove('hidden');
      }
    });
  }

  // Handle species selection change
  if (itemSpeciesSelect) {
    itemSpeciesSelect.addEventListener('change', () => {
      const selectedSpecies = itemSpeciesSelect.value;
      if (itemSpeciesOther) itemSpeciesOther.classList.toggle('hidden', selectedSpecies !== '14');
    });
  }

  // Handle style selection change
  if (itemStyleSelect) {
    itemStyleSelect.addEventListener('change', () => {
      if (itemStyleOther) itemStyleOther.classList.toggle('hidden', itemStyleSelect.value !== '7');
    });
  }

  // Handle material selection change
  if (itemMaterialSelect) {
    itemMaterialSelect.addEventListener('change', () => {
      if (itemMaterialOther) itemMaterialOther.classList.toggle('hidden', itemMaterialSelect.value !== '4');
    });
  }

  // Handle shape selection change
  if (itemShapeSelect) {
    itemShapeSelect.addEventListener('change', () => {
      if (itemShapeOther) itemShapeOther.classList.toggle('hidden', itemShapeSelect.value !== '7');
    });
  }

  // Handle color selection change
  if (itemColorSelect) {
    itemColorSelect.addEventListener('change', () => {
      if (itemColorOther) itemColorOther.classList.toggle('hidden', itemColorSelect.value !== '6');
    });
  }

  // Handle origin selection change
  if (itemOriginSelect) {
    itemOriginSelect.addEventListener('change', () => {
      if (itemOriginOther) itemOriginOther.classList.toggle('hidden', itemOriginSelect.value !== '4');
    });
  }

  // Handle essential type selection change
  if (itemEssentialTypeSelect) {
    itemEssentialTypeSelect.addEventListener('change', () => {
      const selectedEssentialType = itemEssentialTypeSelect.value;
      if (wireFields) wireFields.classList.add('hidden');
      if (toolsFields) toolsFields.classList.add('hidden');

      if (selectedEssentialType === '4') {
        if (wireFields) wireFields.classList.remove('hidden');
      } else if (selectedEssentialType === '7') {
        if (toolsFields) toolsFields.classList.remove('hidden');
      }

      if (itemEssentialOther) itemEssentialOther.classList.toggle('hidden', selectedEssentialType !== '8');
    });
  }

  // Handle wire type selection change
  if (itemWireTypeSelect) {
    itemWireTypeSelect.addEventListener('change', () => {
      if (itemWireOther) itemWireOther.classList.toggle('hidden', itemWireTypeSelect.value !== '3');
    });
  }

  // Handle tool type selection change
  if (itemToolTypeSelect) {
    itemToolTypeSelect.addEventListener('change', () => {
      if (itemToolOther) itemToolOther.classList.toggle('hidden', itemToolTypeSelect.value !== '6');
    });
  }

  // Handle size selection change
  if (itemSizeSelect) {
    itemSizeSelect.addEventListener('change', () => {
      if (itemSizeOther) itemSizeOther.classList.toggle('hidden', itemSizeSelect.value !== '7');
    });
  }
});
