import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["species", "style", "speciesOther", "styleOther"]

  connect() {
    this.hideAll();
  }

  updateFields(event) {
    const selectedPlant = event.target.value;
    this.hideAll();

    switch (selectedPlant) {
      case 'species':
        this.speciesTarget.classList.remove('hidden');
        this.speciesTarget.querySelectorAll('input, select, textarea').forEach(input => {
          if (!input.id.includes('other')) {
            input.setAttribute('required', 'true');
          } else {
            input.removeAttribute('required');
          }
        });
        break;
      case 'style':
        this.styleTarget.classList.remove('hidden');
        this.styleTarget.querySelectorAll('input, select, textarea').forEach(input => {
          if (!input.id.includes('other')) {
            input.setAttribute('required', 'true');
          } else {
            input.removeAttribute('required');
          }
        });
        break;
      case 'other':
        this.speciesOtherTarget.classList.remove('hidden');
        this.styleOtherTarget.classList.remove('hidden');
        break;
      default:
        break;
    }
  }

  hideAll() {
    this.speciesTarget.classList.add('hidden');
    this.styleTarget.classList.add('hidden');
    this.speciesOtherTarget.classList.add('hidden');
    this.styleOtherTarget.classList.add('hidden');
  }
}
