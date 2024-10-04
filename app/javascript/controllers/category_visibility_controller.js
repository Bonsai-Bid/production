// app/javascript/controllers/category_visibility_controller.js
import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = [
    "category", "plant", "container", "essential", "wire", "tool", "brand", "condition",
    "material_other", "shape_other", "color_other", "origin_other", "size_other",
    "essential_other", "wire_other", "tool_other", "condition_other", "species_other", "style_other", "stage_other"
  ]

  connect() {
    this.updateVisibility()
  }

  updateVisibility() {
    const selectedCategory = this.categoryTarget.value
    this.hideAllFields()

    switch (selectedCategory) {
      case 'plant':
        this.showPlantFields()
        this.showContainerFields()
        break
      case 'container':
        this.showContainerFields()
        break
      case 'essential':
        this.showEssentialFields()
        break
    }
  }

  hideAllFields() {
    this.plantTarget.classList.add('hidden')
    this.containerTarget.classList.add('hidden')
    this.essentialTarget.classList.add('hidden')
    this.wireTarget.classList.add('hidden')
    this.toolTarget.classList.add('hidden')
    this.brandTarget.classList.add('hidden')
    this.conditionTarget.classList.add('hidden')
    this.material_otherTarget.classList.add('hidden')
    this.shape_otherTarget.classList.add('hidden')
    this.color_otherTarget.classList.add('hidden')
    this.origin_otherTarget.classList.add('hidden')
    this.size_otherTarget.classList.add('hidden')
    this.essential_otherTarget.classList.add('hidden')
    this.wire_otherTarget.classList.add('hidden')
    this.tool_otherTarget.classList.add('hidden')
    this.condition_otherTarget.classList.add('hidden')
  }

  showPlantFields() {
    this.plantTarget.classList.remove('hidden')
  }

  showContainerFields() {
    this.containerTarget.classList.remove('hidden')
  }

  showEssentialFields() {
    this.essentialTarget.classList.remove('hidden')
  }
  updateEssentialFields(event) {
    const selectedEssential = event.target.value;
  
    // Hide all essential subfields first
    this.hideEssentialSubFields();
  
    // Show specific fields based on selected value
    switch (selectedEssential) {
      case 'wire':
        this.wireTarget.classList.remove('hidden');
        break;
      case 'tool':
        this.toolTarget.classList.remove('hidden');
        this.brandTarget.classList.remove('hidden');
        this.conditionTarget.classList.remove('hidden');
        break;
      case 'other':
        this.essential_otherTarget.classList.remove('hidden');
        break;
      default:
        break;
    }
  
    // Also trigger the updateOtherField logic to show/hide "other" fields
    this.updateOtherField(event);
  }
  
  hideEssentialSubFields() {
    // Hide all fields initially
    this.wireTarget.classList.add('hidden');
    this.toolTarget.classList.add('hidden');
    this.brandTarget.classList.add('hidden');
    this.conditionTarget.classList.add('hidden');
    this.essential_otherTarget.classList.add('hidden');
  }
  
  updateOtherField(event) {
    const selectElement = event.target;
    const value = selectElement.value;
  
    // Determine which "other" field needs to be shown based on select element
    let otherField;
    
    switch (selectElement.id) {
      case "item_plant_species":
        otherField = this.species_otherTarget;
        break;
      case "item_plant_style":
        otherField = this.style_otherTarget;
        break;
      case "item_plant_stage":
        otherField = this.stage_otherTarget;
        break;
      case "item_container_material":
        otherField = this.material_otherTarget;
        break;
      case "item_container_shape":
        otherField = this.shape_otherTarget;
        break;
      case "item_container_color":
        otherField = this.color_otherTarget;
        break;
      case "item_container_origin":
        otherField = this.origin_otherTarget;
        break;
      case "item_container_size":
        otherField = this.size_otherTarget;
        break;
      case "item_wire_type":
        otherField = this.wire_otherTarget;
        break;
      case "item_tool_type":
        otherField = this.tool_otherTarget;
        break;
      case "item_condition":
        otherField = this.condition_otherTarget;
        break;
      case "item_essential_type":
        otherField = this.essential_otherTarget;
        break;
      default:
        otherField = null;
    }
  
    // If a matching "other" field exists and the value includes "other"
    if (otherField) {
      if (value.includes('other')) {
        otherField.classList.remove('hidden');
        otherField.required = true;
      } else {
        otherField.classList.add('hidden');
        otherField.required = false;
        otherField.value = '';  // Clear the input when hidden
      }
    }
  }
  // updateEssentialFields(event) {
  //   const selectedEssential = event.target.value
  //   this.hideEssentialSubFields()

  //   switch (selectedEssential) {
  //     case 'wire':
  //       this.wireTarget.classList.remove('hidden')
  //       break
  //     case 'tool':
  //       this.toolTarget.classList.remove('hidden')
  //       this.brandTarget.classList.remove('hidden')
  //       this.conditionTarget.classList.remove('hidden')
  //       break
  //     case 'other_essential':
  //       this.essential_otherTarget.classList.remove('hidden')
  //       break
  //   }
  // }

  // hideEssentialSubFields() {
  //   this.wireTarget.classList.add('hidden')
  //   this.toolTarget.classList.add('hidden')
  //   this.brandTarget.classList.add('hidden')
  //   this.conditionTarget.classList.add('hidden')
  //   this.essential_otherTarget.classList.add('hidden')
  // }
  // updateOtherField(event) {
  //   const selectElement = event.target;
  //   const value = selectElement.value;
  
  //   // Determine which "other" field needs to be shown
  //   let otherField;
    
  //   switch (selectElement.id) {
  //     case "item_wire_type":
  //       otherField = this.wire_otherTarget;
  //       break;
  //     case "item_tool_type":
  //       otherField = this.tool_otherTarget;
  //       break;
  //     case "item_condition":
  //       otherField = this.condition_otherTarget;
  //       break;
  //     case "item_essential_type":
  //       otherField = this.essential_otherTarget;
  //       break;
  //     default:
  //       otherField = null;
  //   }
  
  //   // If there's a matching "other" field and the value includes "other"
  //   if (otherField) {
  //     if (value.includes('other')) {
  //       otherField.classList.remove('hidden');
  //       otherField.required = true;
  //     } else {
  //       otherField.classList.add('hidden');
  //       otherField.required = false;
  //       otherField.value = '';  // Clear the input if it's hidden
  //     }
  //   }
  // }
  // updateOtherField(event) {
  //   const selectElement = event.target;
  //   const value = selectElement.value;
  
  //   // Accessing the target directly as essential_otherTarget
  //   const otherField = this.essential_otherTarget;
  
  //   if (value.includes('other')) {
  //     // Show the other field
  //     otherField.classList.remove('hidden');
  //     otherField.required = true;
  //   } else {
  //     // Hide the other field
  //     otherField.classList.add('hidden');
  //     otherField.required = false;
  //     otherField.value = '';  // Clear the input if it's hidden
  //   }
  // }
  
}