import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["input", "preview"]

  connect() {
    this.filesArray = []
  }

  handleFileSelect(event) {
    const newFiles = Array.from(event.target.files)
    this.filesArray = this.filesArray.concat(newFiles)
    this.updatePreview()
  }

  updatePreview() {
    this.previewTarget.innerHTML = ''
    this.filesArray.forEach((file, index) => {
      const reader = new FileReader()
      reader.onload = (e) => {
        const imgElement = document.createElement('div')
        imgElement.innerHTML = `
          <div class="relative h-24 w-24 m-2">
            <img src="${e.target.result}" class="h-full w-full object-cover border rounded">
            <button data-action="click->image-upload#removeImage" data-index="${index}" class="absolute top-0 right-0 bg-red-500 text-white rounded-full p-1">
              X
            </button>
          </div>
        `
        this.previewTarget.appendChild(imgElement)
      }
      reader.readAsDataURL(file)
    })
  }

  removeImage(event) {
    const index = parseInt(event.currentTarget.dataset.index)
    this.filesArray.splice(index, 1)
    this.updatePreview()
  }
}
