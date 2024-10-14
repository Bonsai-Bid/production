import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = [
    "speciesSelect", "speciesOther",
    "styleSelect", "styleOther",
    "materialSelect", "materialOther",
    "shapeSelect", "shapeOther",
    "colorSelect", "colorOther",
    "originSelect", "originOther",
    "sizeSelect", "sizeOther",
    "essentialSelect", "essentialOther",
    "wireSelect", "wireOther",
    "toolSelect", "toolOther"
  ]

  connect() {
    this.toggleOtherField();
  }

  toggleOtherField() {
    this.handleField(this.speciesSelectTarget.value, "species_other", this.speciesOtherTarget);
    this.handleField(this.styleSelectTarget.value, "style_other", this.styleOtherTarget);
    this.handleField(this.materialSelectTarget.value, "material_other", this.materialOtherTarget);
    this.handleField(this.shapeSelectTarget.value, "shape_other", this.shapeOtherTarget);
    this.handleField(this.colorSelectTarget.value, "color_other", this.colorOtherTarget);
    this.handleField(this.originSelectTarget.value, "origin_other", this.originOtherTarget);
    this.handleField(this.sizeSelectTarget.value, "size_other", this.sizeOtherTarget);
    this.handleField(this.essentialSelectTarget.value, "essential_other", this.essentialOtherTarget);
    this.handleField(this.wireSelectTarget.value, "wire_other", this.wireOtherTarget);
    this.handleField(this.toolSelectTarget.value, "tool_other", this.toolOtherTarget);
  }

  handleField(selectedValue, otherValue, otherFieldTarget) {
    if (selectedValue === otherValue) {
      otherFieldTarget.classList.remove('hidden');
      otherFieldTarget.required = true;  // Set required only when visible
    } else {
      otherFieldTarget.classList.add('hidden');
      otherFieldTarget.required = false;  // Remove required when hidden
      otherFieldTarget.value = '';  // Clear value when hidden
    }
  }
}
