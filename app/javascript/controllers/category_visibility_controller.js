// app/javascript/controllers/category_visibility_controller.js
import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["category", "plant", "container", "essential"]

  connect() {
    this.updateVisibility()
  }

  updateVisibility() {
    const selectedCategory = this.categoryTarget.value
    console.log("Handling visibility for category:", selectedCategory)

    this.hideAllFields()
    this.showSelectedCategoryFields(selectedCategory)
  }

  hideAllFields() {
    this.plantTarget.classList.add('hidden')
    this.containerTarget.classList.add('hidden')
    this.essentialTarget.classList.add('hidden')
  }

  showSelectedCategoryFields(category) {
    switch(category) {
      case 'plant':
        this.plantTarget.classList.remove('hidden')
        this.containerTarget.classList.remove('hidden')
        break
      case 'container':
        this.containerTarget.classList.remove('hidden')
        break
      case 'essential':
        this.essentialTarget.classList.remove('hidden')
        break
    }
  }

  handleCategoryVisibility(selectedCategory) {
    const categoryFields = {
      'plant': ['species', 'style', 'stage', 'material', 'shape', 'color', 'origin', 'size'],
      'container': ['material', 'shape', 'color', 'origin', 'size'],
      'essential': ['essential_type', 'wire', 'tool', 'brand', 'condition']
    };

    const allFields = ['plant_fields', 'container_fields', 'essential_fields'];
    
    allFields.forEach(fieldId => {
      const field = document.getElementById(fieldId);
      if (field) {
        field.classList.add('hidden');
      }
    });

    if (selectedCategory in categoryFields) {
      const categoryContainer = document.getElementById(`${selectedCategory}_fields`);
      if (categoryContainer) {
        categoryContainer.classList.remove('hidden');
        
        categoryContainer.querySelectorAll(':scope > div').forEach(div => {
          div.classList.remove('hidden');
        });
      }
    }
  }
}