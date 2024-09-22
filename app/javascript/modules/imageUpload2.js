import { handleFileSelect } from './handleFileSelect';
import { handleFormSubmit } from './handleFormSubmit';

export function imageUpload() {
  const imageUpload = document.getElementById('image-upload');
  const imagePreview = document.getElementById('image-preview');
  const form = document.querySelector('form');
  let filesArray = [];

  if (imageUpload) {
    imageUpload.addEventListener('change', (e) => handleFileSelect(e, filesArray, imagePreview));
  }

  if (form) {
    form.addEventListener('submit', (e) => handleFormSubmit(e, form, filesArray));
  }
}
