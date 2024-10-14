import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["wire", "tool"]

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
      default:
        break;
    }
  }

  hideAll() {
    this.wireTarget.classList.add('hidden');
    this.toolTarget.classList.add('hidden');
  }
}
