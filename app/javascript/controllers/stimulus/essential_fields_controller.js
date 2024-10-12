import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["wire", "tool", "wireOther", "toolOther", "essentialOther"]

  connect() {
    this.hideAll();
  }

  updateFields(event) {
    const selectedEssential = event.target.value;
    this.hideAll();

    switch (selectedEssential) {
      case 'wire':
        this.wireTarget.classList.remove('hidden');
        break;
      case 'tool':
        this.toolTarget.classList.remove('hidden');
        break;
      case 'other':
        this.wireOtherTarget.classList.remove('hidden');
        this.toolOtherTarget.classList.remove('hidden');
        this.essentialOtherTarget.classList.remove('hidden');  // Show the 'other' field for essential
        break;
      default:
        break;
    }
  }

  hideAll() {
    this.wireTarget.classList.add('hidden');
    this.toolTarget.classList.add('hidden');
    this.wireOtherTarget.classList.add('hidden');
    this.toolOtherTarget.classList.add('hidden');
    this.essentialOtherTarget.classList.add('hidden');  // Hide the 'other' field for essential
  }
}
