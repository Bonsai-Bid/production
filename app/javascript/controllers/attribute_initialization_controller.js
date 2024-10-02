// app/javascript/controllers/attribute_initialization_controller.js
import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["select", "other", "wireFields", "toolsFields"]

  connect() {
    this.handleSelectChange()
  }

  handleSelectChange() {
    const selectedValue = this.selectTarget.value
    this.toggleOtherField(selectedValue)
    this.handleEssentialFields(selectedValue)
    this.updateRequiredFields(selectedValue)
  }

  toggleOtherField(selectedValue) {
    const showOtherValues = [
      'material_other', 'shape_other', 'color_other', 'size_other',
      'origin_other', 'essential_other', 'wire_other', 'tool_other',
      'species_other', 'style_other', 'stage_other'
    ]

    if (showOtherValues.includes(selectedValue)) {
      this.otherTarget.classList.remove('hidden')
      this.otherTarget.removeAttribute('aria-hidden')
    } else {
      this.otherTarget.classList.add('hidden')
      this.otherTarget.setAttribute('aria-hidden', 'true')
      this.otherTarget.value = ''
    }
  }

  handleEssentialFields(selectedValue) {
    if (this.selectTarget.id === 'item_essential_type') {
      if (selectedValue === 'wire') {
        this.wireFieldsTarget.classList.remove('hidden')
        this.toolsFieldsTarget.classList.add('hidden')
        this.clearFormFields(this.toolsFieldsTarget)
      } else if (selectedValue === 'tools') {
        this.toolsFieldsTarget.classList.remove('hidden')
        this.wireFieldsTarget.classList.add('hidden')
        this.clearFormFields(this.wireFieldsTarget)
      } else {
        this.wireFieldsTarget.classList.add('hidden')
        this.toolsFieldsTarget.classList.add('hidden')
        this.clearFormFields(this.wireFieldsTarget)
        this.clearFormFields(this.toolsFieldsTarget)
      }
    }
  }

  updateRequiredFields(selectedValue) {
    // Implement the logic to update required fields based on the selected category
    // This should cover the functionality from form_conditionals.js
  }

  clearFormFields(container) {
    const inputs = container.querySelectorAll('input, select, textarea')
    inputs.forEach(input => {
      input.value = ''
      input.required = false
    })
  }
}