import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["category", "plant", "container", "essential"]

  connect() {
    this.updateVisibility();  // Initialize visibility on page load or connection
  }

  updateVisibility() {
    const selectedCategory = this.categoryTarget.value;
    this.hideAllFields();

    switch (selectedCategory) {
      case 'plant':
        this.plantTarget.classList.remove('hidden');
        this.containerTarget.classList.remove('hidden');  // Also show container when 'plant' is selected
        break;
      case 'container':
        this.containerTarget.classList.remove('hidden');
        break;
      case 'essential':
        this.essentialTarget.classList.remove('hidden');
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
  }
}
