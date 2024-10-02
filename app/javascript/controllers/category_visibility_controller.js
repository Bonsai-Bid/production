// app/javascript/controllers/category_visibility_controller.js
import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = [
    "category", "plant", "container", "essential", "wire", "tool", "brand", "condition",
    "material_other", "shape_other", "color_other", "origin_other", "size_other",
    "essential_other", "wire_other", "tool_other", "condition_other"
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
    const selectedEssential = event.target.value
    this.hideEssentialSubFields()

    switch (selectedEssential) {
      case 'wire':
        this.wireTarget.classList.remove('hidden')
        break
      case 'tool':
        this.toolTarget.classList.remove('hidden')
        this.brandTarget.classList.remove('hidden')
        this.conditionTarget.classList.remove('hidden')
        break
      case 'other_essential':
        this.essential_otherTarget.classList.remove('hidden')
        break
    }
  }

  hideEssentialSubFields() {
    this.wireTarget.classList.add('hidden')
    this.toolTarget.classList.add('hidden')
    this.brandTarget.classList.add('hidden')
    this.conditionTarget.classList.add('hidden')
    this.essential_otherTarget.classList.add('hidden')
  }

  updateOtherField(event) {
    const selectElement = event.target
    const otherFieldTarget = `${selectElement.name.replace(/[\[\]]/g, '')}_otherTarget`
    const otherField = this.targets.find(otherFieldTarget)

    if (selectElement.value.includes('other')) {
      otherField.classList.remove('hidden')
    } else {
      otherField.classList.add('hidden')
    }
  }
}