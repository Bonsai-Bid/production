import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["form", "convertField", "optionalField"]

  submit(event) {
    event.preventDefault()
    this.convertFields()
    this.disableEmptyOptionalFields()
    this.formTarget.submit()
  }

  convertFields() {
    this.convertFieldTargets.forEach(field => {
      if (field.value !== '') {
        field.value = parseInt(field.value, 10)
      }
    })
  }

  disableEmptyOptionalFields() {
    this.optionalFieldTargets.forEach(field => {
      if (field.value === '') {
        field.disabled = true
      }
    })
  }
}
