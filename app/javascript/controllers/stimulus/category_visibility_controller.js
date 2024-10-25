// app/javascript/controllers/category_visibility_controller.js
import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["category", "plant", "container", "essential"];

  connect() {
    console.log("Category target:", this.categoryTarget);
    this.updateVisibility();
  }

  updateVisibility() {
    const category = this.categoryTarget.value;

    this.hideAll();

    if (category === "plant") {
      this.plantTarget.classList.remove("hidden");
      this.containerTarget.classList.remove("hidden");
    } else if (category === "container") {
      this.containerTarget.classList.remove("hidden");
    } else if (category === "essential") {
      this.essentialTarget.classList.remove("hidden");
    }
  }

  hideAll() {
    this.plantTarget.classList.add("hidden");
    this.containerTarget.classList.add("hidden");
    this.essentialTarget.classList.add("hidden");
  }
}
