import { handleFileSelect } from './handleFileSelect'; // Make sure to use the correct path
import { handleFormSubmit } from '../forms/handleFormSubmit'; // Make sure to use the correct path


function addEventListeners(element, eventType, handler) {
  if (element) {
    element.addEventListener(eventType, handler);
  }
}

export function initializeImageUpload() {
  const imageUpload = document.getElementById('image-upload');
  if (imageUpload) {
    imageUpload.addEventListener('change', handleFileSelect); // Pass event when file changes
  } else {
    console.error("Image upload input not found.");
  }
  const form = document.querySelector('form');

  addEventListeners(imageUpload, 'change', handleFileSelect);
  addEventListeners(form, 'submit', handleFormSubmit);

  document.getElementById('image-preview').addEventListener('click', (event) => {
    if (event.target.matches('.cursor-pointer')) {
      const index = event.target.dataset.index;
      handleRemove(index);
    }
  });
}
