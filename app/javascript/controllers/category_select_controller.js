import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["select", "plant", "container", "essential"]

  connect() {
    this.updateFields()
  }

  updateFields() {
    const selectedCategory = this.selectTarget.value
    this.hideAllFields()

    if (selectedCategory === 'plant') {
      this.plantTarget.classList.remove('hidden')
      this.containerTarget.classList.remove('hidden')
    } else if (selectedCategory === 'container') {
      this.containerTarget.classList.remove('hidden')
    } else if (selectedCategory === 'essential') {
      this.essentialTarget.classList.remove('hidden')
    }
  }

  hideAllFields() {
    this.plantTarget.classList.add('hidden')
    this.containerTarget.classList.add('hidden')
    this.essentialTarget.classList.add('hidden')
  }
}
