import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["category", "plant", "container", "essential", "wire", "tool", "brand", "condition"]

  connect() {
    this.updateVisibility();  // Initialize visibility on page load or connection
  }

  updateVisibility() {
    const selectedCategory = this.categoryTarget.value;
    this.hideAllFields();
    this.removeRequired(); // Remove required from all fields first

    switch (selectedCategory) {
      case 'plant':
        this.plantTarget.classList.remove('hidden');
        this.containerTarget.classList.remove('hidden');  // Show plant and container fields
        this.addRequired(this.plantTarget);
        this.addRequired(this.containerTarget);
        break;
      case 'container':
        this.containerTarget.classList.remove('hidden');  // Only show container fields
        this.addRequired(this.containerTarget);
        break;
      case 'essential':
        this.essentialTarget.classList.remove('hidden');  // Show essential section
        this.addRequired(this.essentialTarget);
        this.updateEssentialFields();  // Update visibility for wire or tool within essential section
        break;
      default:
        break;
    }
  }

  hideAllFields() {
    // Hide all main sections (plant, container, essential)
    this.plantTarget.classList.add('hidden');
    this.containerTarget.classList.add('hidden');
    this.essentialTarget.classList.add('hidden');
    this.hideEssentialFields();  // Also hide wire/tool/brand/condition when essential is hidden
  }

  hideEssentialFields() {
    // Hide all subfields related to essential type
    this.wireTarget.classList.add('hidden');
    this.toolTarget.classList.add('hidden');
    this.brandTarget.classList.add('hidden');
    this.conditionTarget.classList.add('hidden');
  }

  updateEssentialFields() {
    const selectedEssential = this.essentialTarget.querySelector("select").value;  // Get the selected essential type
    this.hideEssentialFields();  // Hide all subfields first

    switch (selectedEssential) {
      case 'wire':
        this.wireTarget.classList.remove('hidden');
        this.addRequired(this.wireTarget);  // Add required when wire is shown
        break;
      case 'tool':
        this.toolTarget.classList.remove('hidden');
        this.brandTarget.classList.remove('hidden');
        this.conditionTarget.classList.remove('hidden');
        this.addRequired(this.toolTarget);  // Add required when tool is shown
        this.addRequired(this.brandTarget);
        this.addRequired(this.conditionTarget);
        break;
      default:
        break;
    }
  }

  removeRequired() {
    // Remove required from all form fields
    [this.plantTarget, this.containerTarget, this.essentialTarget, this.wireTarget, this.toolTarget, this.brandTarget, this.conditionTarget].forEach(target => {
      if (target) {
        target.querySelectorAll('input, select, textarea').forEach(field => {
          field.required = false;
        });
      }
    });
  }

  addRequired(target) {
    // Add required to form fields within the visible target, but only if the field is not hidden
    target.querySelectorAll('input, select, textarea').forEach(field => {
      if (!field.classList.contains('hidden')) {
        field.required = true;
      }
    });
  }
}
