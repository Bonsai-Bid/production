import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["material", "shape", "materialOther", "shapeOther"]

  connect() {
    this.hideAll();
  }

  updateFields(event) {
    const selectedContainer = event.target.value;
    this.hideAll();

    switch (selectedContainer) {
      case 'material':
        this.materialTarget.classList.remove('hidden');
        break;
      case 'shape':
        this.shapeTarget.classList.remove('hidden');
        break;
      case 'other':
        this.materialOtherTarget.classList.remove('hidden');
        this.shapeOtherTarget.classList.remove('hidden');
        break;
      default:
        break;
    }
  }

  hideAll() {
    this.materialTarget.classList.add('hidden');
    this.shapeTarget.classList.add('hidden');
    this.materialOtherTarget.classList.add('hidden');
    this.shapeOtherTarget.classList.add('hidden');
  }
}
