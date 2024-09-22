import { handleFileSelect } from './handleFileSelect';
import { handleFormSubmit } from './handleFormSubmit';

export const initializeImageUpload = () => {
  const imageUpload = document.getElementById('image-upload');
  const form = document.querySelector('form');

  if (imageUpload) {
    imageUpload.addEventListener('change', handleFileSelect);
  }

  if (form) {
    form.addEventListener('submit', handleFormSubmit);
  }
};
