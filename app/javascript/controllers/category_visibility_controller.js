// app/javascript/controllers/category_visibility_controller.js
import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = [
    "category", "plant", "container", "essential", "wire", "tool", "brand", "condition",
    "material_other", "shape_other", "color_other", "origin_other", "size_other",
    "essential_other", "wire_other", "tool_other", "species_other", "style_other"
  ]

  connect() {
    this.updateVisibility()
  }

  updateVisibility() {
    const selectedCategory = this.categoryTarget.value;
    this.hideAllFields();

    switch (selectedCategory) {
      case 'plant':
        this.showPlantFields();
        this.showContainerFields(); // Also show container fields when 'plant' is selected
        break;
      case 'container':
        this.showContainerFields();
        break;
      case 'essential':
        this.showEssentialFields();
        break;
    }
  }

  hideAllFields() {
    this.plantTarget.classList.add('hidden');
    this.containerTarget.classList.add('hidden');
    this.essentialTarget.classList.add('hidden');
    this.wireTarget.classList.add('hidden');
    this.toolTarget.classList.add('hidden');
    this.brandTarget.classList.add('hidden');
    this.conditionTarget.classList.add('hidden');
    this.material_otherTarget.classList.add('hidden');
    this.shape_otherTarget.classList.add('hidden');
    this.color_otherTarget.classList.add('hidden');
    this.origin_otherTarget.classList.add('hidden');
    this.size_otherTarget.classList.add('hidden');
    this.essential_otherTarget.classList.add('hidden');
    this.wire_otherTarget.classList.add('hidden');
    this.tool_otherTarget.classList.add('hidden');

    // Remove required attributes for all inputs when fields are hidden
    this.removeRequiredFromAllFields();
  }

  removeRequiredFromAllFields() {
    // Remove 'required' attribute for all form fields
    const allTargets = [this.plantTarget, this.containerTarget, this.essentialTarget, this.wireTarget, this.toolTarget];
    allTargets.forEach(target => {
      if (target) {
        target.querySelectorAll('input, select, textarea').forEach(input => {
          input.removeAttribute('required');  // Use removeAttribute instead of setting required to false
        });
      }
    });
  }

  showPlantFields() {
    this.plantTarget.classList.remove('hidden');
    this.plantTarget.querySelectorAll('input, select, textarea').forEach(input => {
      if (!input.id.includes('other')) {
        input.setAttribute('required', 'true');  // Use setAttribute to make fields required
      }
    });
  }

  showContainerFields() {
    this.containerTarget.classList.remove('hidden');
    this.containerTarget.querySelectorAll('input, select, textarea').forEach(input => {
      if (!input.id.includes('other')) {
        input.setAttribute('required', 'true');  // Use setAttribute to make fields required
      }
    });
  }

  showEssentialFields() {
    this.essentialTarget.classList.remove('hidden');
    this.essentialTarget.querySelectorAll('input, select, textarea').forEach(input => {
      if (!input.id.includes('other')) {
        input.setAttribute('required', 'true');  // Use setAttribute to make fields required
      }
    });
  }

  updateEssentialFields(event) {
    const selectedEssential = event.target.value;
    this.hideEssentialSubFields(); // Hide all subfields first

    switch (selectedEssential) {
      case 'wire':
        this.showWireFields();
        break;
      case 'tool':
        this.showToolFields();
        break;
      case 'other':
        this.showEssentialOtherField();
        break;
      default:
        break;
    }

    this.updateOtherField(event);
  }

  hideEssentialSubFields() {
    this.wireTarget.classList.add('hidden');
    this.toolTarget.classList.add('hidden');
    this.brandTarget.classList.add('hidden');
    this.conditionTarget.classList.add('hidden');
    this.essential_otherTarget.classList.add('hidden');

    // Remove required attributes for essential subfields
    this.removeRequiredFromEssentialFields();
  }

  removeRequiredFromEssentialFields() {
    [this.wireTarget, this.toolTarget, this.brandTarget, this.conditionTarget, this.essential_otherTarget].forEach(target => {
      if (target) {
        target.querySelectorAll('input, select, textarea').forEach(input => {
          input.removeAttribute('required');  // Use removeAttribute to remove required fields
        });
      }
    });
  }

  showWireFields() {
    this.wireTarget.classList.remove('hidden');
    this.wireTarget.querySelectorAll('input, select, textarea').forEach(input => {
      if (!input.id.includes('other')) {
        input.setAttribute('required', 'true');  // Use setAttribute to make fields required
      }
    });
  }

  showToolFields() {
    this.toolTarget.classList.remove('hidden');
    this.toolTarget.querySelectorAll('input, select, textarea').forEach(input => {
      if (!input.id.includes('other')) {
        input.setAttribute('required', 'true');  // Use setAttribute to make fields required
      }
    });
    this.brandTarget.classList.remove('hidden');
    this.conditionTarget.classList.remove('hidden');
  }

  showEssentialOtherField() {
    this.essential_otherTarget.classList.remove('hidden');
    this.essential_otherTarget.querySelectorAll('input, select, textarea').forEach(input => {
      input.setAttribute('required', 'true');  // Use setAttribute to make 'other' field required
    });
  }

  updatePlantFields(event) {
    const selectedPlant = event.target.value;
    this.hidePlantSubFields(); // Hide all subfields first
  
    switch (selectedPlant) {
      case 'species':
        this.speciesTarget.classList.remove('hidden');
        this.speciesTarget.querySelectorAll('input, select, textarea').forEach(input => {
          if (!input.id.includes('other')) {
            input.setAttribute('required', 'true');  // Set required for species, but not for 'other'
          }
        });
        // Make sure the 'other' fields are not required when 'species' is selected
        this.species_otherTarget.querySelectorAll('input, select, textarea').forEach(input => {
          input.removeAttribute('required');
        });
        break;
        
      case 'style':
        this.styleTarget.classList.remove('hidden');
        this.styleTarget.querySelectorAll('input, select, textarea').forEach(input => {
          if (!input.id.includes('other')) {
            input.setAttribute('required', 'true');  // Set required for style, but not for 'other'
          }
        });
        // Make sure the 'other' fields are not required when 'style' is selected
        this.style_otherTarget.querySelectorAll('input, select, textarea').forEach(input => {
          input.removeAttribute('required');
        });
        break;
        
      case 'other':
        this.species_otherTarget.classList.remove('hidden');
        this.style_otherTarget.classList.remove('hidden');
        
        this.species_otherTarget.querySelectorAll('input, select, textarea').forEach(input => {
          input.setAttribute('required', 'true');  // Only make 'other' field required
        });
        this.style_otherTarget.querySelectorAll('input, select, textarea').forEach(input => {
          input.setAttribute('required', 'true');  // Only make 'other' field required
        });
        break;
        
      default:
        break;
    }
  
    this.updateOtherField(event);  // Ensure further updates to the 'Other' field visibility/requirement
  }
  

  hidePlantSubFields() {
    this.speciesTarget.classList.add('hidden');
    this.styleTarget.classList.add('hidden');
    this.species_otherTarget.classList.add('hidden');
    this.style_otherTarget.classList.add('hidden');

    // Remove required attributes when hidden
    this.removeRequiredFromPlantFields();
  }

  removeRequiredFromPlantFields() {
    [this.speciesTarget, this.styleTarget, this.species_otherTarget, this.style_otherTarget].forEach(target => {
      if (target) {
        target.querySelectorAll('input, select, textarea').forEach(input => {
          input.removeAttribute('required');  // Use removeAttribute to remove required fields
        });
      }
    });
  }

  updateContainerFields(event) {
    const selectedContainer = event.target.value;
    this.hideContainerSubFields(); // Hide all subfields first

    switch (selectedContainer) {
      case 'material':
        this.materialTarget.classList.remove('hidden');
        this.materialTarget.querySelectorAll('input, select, textarea').forEach(input => {
          if (!input.id.includes('other')) {
            input.setAttribute('required', 'true');  // Use setAttribute to make fields required
          }
        });
        break;
      case 'shape':
        this.shapeTarget.classList.remove('hidden');
        this.shapeTarget.querySelectorAll('input, select, textarea').forEach(input => {
          if (!input.id.includes('other')) {
            input.setAttribute('required', 'true');  // Use setAttribute to make fields required
          }
        });
        break;
      case 'other':
        this.material_otherTarget.classList.remove('hidden');
        this.shape_otherTarget.classList.remove('hidden');
        this.material_otherTarget.querySelectorAll('input, select, textarea').forEach(input => {
          input.setAttribute('required', 'true');  // Use setAttribute to make 'other' field required
        });
        this.shape_otherTarget.querySelectorAll('input, select, textarea').forEach(input => {
          input.setAttribute('required', 'true');  // Use setAttribute to make 'other' field required
        });
        break;
      default:
        break;
    }

    this.updateOtherField(event);
  }

  hideContainerSubFields() {
    this.materialTarget.classList.add('hidden');
    this.shapeTarget.classList.add('hidden');
    this.material_otherTarget.classList.add('hidden');
    this.shape_otherTarget.classList.add('hidden');

    // Remove required attributes when hidden
    this.removeRequiredFromContainerFields();
  }

  removeRequiredFromContainerFields() {
    [this.materialTarget, this.shapeTarget, this.material_otherTarget, this.shape_otherTarget].forEach(target => {
      if (target) {
        target.querySelectorAll('input, select, textarea').forEach(input => {
          input.removeAttribute('required');  // Use removeAttribute to remove required fields
        });
      }
    });
  }

  updateOtherField(event) {
    const selectElement = event.target;
    const value = selectElement.value;

    let otherField;

    switch (selectElement.id) {
      case "item_plant_species":
        otherField = this.species_otherTarget;
        break;
      case "item_plant_style":
        otherField = this.style_otherTarget;
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
      case "item_essential_type":
        otherField = this.essential_otherTarget;
        break;
      default:
        otherField = null;
    }

    if (otherField) {
      if (value.includes('other')) {
        otherField.classList.remove('hidden');
        otherField.setAttribute('required', 'true');  // Use setAttribute to make 'other' field required
      } else {
        otherField.classList.add('hidden');
        otherField.removeAttribute('required');  // Use removeAttribute to remove required field
        otherField.value = '';  // Clear the value when hiding
      }
    }
  }
}
