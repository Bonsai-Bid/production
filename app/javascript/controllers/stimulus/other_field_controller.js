import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["select", "other"]

  connect() {
    this.toggleOtherField()
  }

  toggleOtherField() {
    if (this.selectTarget.value === 'other') {
      this.otherTarget.classList.remove('hidden')
      this.otherTarget.required = true
    } else {
      this.otherTarget.classList.add('hidden')
      this.otherTarget.required = false
      this.otherTarget.value = ''
    }
  }
}
