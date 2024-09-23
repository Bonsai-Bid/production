function addEventListeners(element, eventType, handler) {
  if (element) {
    element.addEventListener(eventType, handler);
  }
}

export function initializeImageUpload() {
  const imageUpload = document.getElementById('image-upload');
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
