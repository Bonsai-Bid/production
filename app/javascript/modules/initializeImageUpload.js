let filesArray = [];

export function initializeImageUpload() {
  const imageUpload = document.getElementById('image-upload');
  const imagePreview = document.getElementById('image-preview');
  const form = document.querySelector('form');

  if (imageUpload) {
    imageUpload.addEventListener('change', handleFileSelect);
  }

  if (form) {
    form.addEventListener('submit', handleFormSubmit);
  }

  function handleFileSelect(event) {
    const newFiles = Array.from(event.target.files);
    filesArray = filesArray.concat(newFiles);
    updateImagePreviews();
    event.target.value = '';
  }

  function handleRemove(index) {
    filesArray.splice(index, 1);
    updateImagePreviews();
  }

  function updateImagePreviews() {
    imagePreview.innerHTML = '';
    filesArray.forEach((file, index) => {
      const reader = new FileReader();
      reader.onload = (e) => {
        const imgElement = createImagePreviewElement(e.target.result, index);
        imagePreview.appendChild(imgElement);
      };
      reader.readAsDataURL(file);
    });
  }

  function createImagePreviewElement(src, index) {
    const imgElement = document.createElement('div');
    imgElement.classList.add('relative', 'h-24', 'w-24', 'm-2');

    const img = document.createElement('img');
    img.src = src;
    img.classList.add('h-full', 'w-full', 'object-cover', 'border', 'rounded');

    const removeButton = document.createElement('button');
    removeButton.innerHTML = '&times;';
    removeButton.classList.add('absolute', 'top-0', 'right-0', 'bg-red-500', 'text-white', 'rounded-full', 'h-6', 'w-6', 'flex', 'items-center', 'justify-center', 'cursor-pointer');
    removeButton.addEventListener('click', () => handleRemove(index));

    imgElement.appendChild(img);
    imgElement.appendChild(removeButton);
    return imgElement;
  }

  function handleFormSubmit(event) {
    event.preventDefault();
    const formData = new FormData(form);
    filesArray.forEach((file) => {
      formData.append(`item[images][]`, file);
    });

    fetch(form.action, {
      method: form.method,
      body: formData,
      headers: {
        'X-CSRF-Token': document.querySelector('meta[name="csrf-token"]').getAttribute('content')
      }
    }).then(response => {
      if (response.ok) {
        console.log('Form submitted successfully');
        // Handle successful submission (e.g., redirect or show a success message)
      } else {
        console.error('Form submission failed');
        // Handle errors (e.g., display an error message)
      }
    }).catch(error => {
      console.error('Error submitting form:', error);
    });
  }
}