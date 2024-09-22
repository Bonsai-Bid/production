let filesArray = [];

export function handleFileSelect(event) {
  const imagePreview = document.getElementById('image-preview');
  const newFiles = Array.from(event.target.files);

  // Add new files to the files array
  filesArray = filesArray.concat(newFiles);

  // Clear previous previews
  imagePreview.innerHTML = '';

  // Loop through the files array and create an image element for each file
  filesArray.forEach((file, index) => {
    const reader = new FileReader();
    reader.onload = (e) => {
      const imgElement = document.createElement('div');
      imgElement.classList.add('relative', 'h-24', 'w-24', 'm-2');

      const img = document.createElement('img');
      img.src = e.target.result;
      img.classList.add('h-full', 'w-full', 'object-cover', 'border', 'rounded');

      const removeButton = document.createElement('button');
      removeButton.innerHTML = '&times;';
      removeButton.classList.add('absolute', 'top-0', 'right-0', 'bg-red-500', 'text-white', 'rounded-full', 'h-6', 'w-6', 'flex', 'items-center', 'justify-center', 'cursor-pointer');
      removeButton.dataset.index = index;

      removeButton.addEventListener('click', () => handleRemove(index));

      imgElement.appendChild(img);
      imgElement.appendChild(removeButton);
      imagePreview.appendChild(imgElement);
    };
    reader.readAsDataURL(file);
  });

  // Clear the file input value to allow selecting the same file again
  event.target.value = '';
}

export function handleRemove(index) {
  // Remove the selected file from the array
  filesArray.splice(index, 1);
  
  // Update the previews
  updateImagePreviews();
}

function updateImagePreviews() {
  const imagePreview = document.getElementById('image-preview');
  imagePreview.innerHTML = ''; // Clear the previous previews

  filesArray.forEach((file, index) => {
    const reader = new FileReader();
    reader.onload = (e) => {
      const imgElement = document.createElement('div');
      imgElement.classList.add('relative', 'h-24', 'w-24', 'm-2');

      const img = document.createElement('img');
      img.src = e.target.result;
      img.classList.add('h-full', 'w-full', 'object-cover', 'border', 'rounded');

      const removeButton = document.createElement('button');
      removeButton.innerHTML = '&times;';
      removeButton.classList.add('absolute', 'top-0', 'right-0', 'bg-red-500', 'text-white', 'rounded-full', 'h-6', 'w-6', 'flex', 'items-center', 'justify-center', 'cursor-pointer');
      removeButton.dataset.index = index;

      removeButton.addEventListener('click', () => handleRemove(index));

      imgElement.appendChild(img);
      imgElement.appendChild(removeButton);
      imagePreview.appendChild(imgElement);
    };
    reader.readAsDataURL(file);
  });
}

export function initializeImageUpload() {
  const imageUpload = document.getElementById('image-upload');
  const form = document.querySelector('form');

  if (imageUpload) {
    imageUpload.addEventListener('change', handleFileSelect);
  }

  if (form) {
    form.addEventListener('submit', handleFormSubmit);
  }
}

function handleFormSubmit(event) {
  event.preventDefault();

  const form = event.target;
  const formData = new FormData(form);

  // Append all selected files to the form data
  filesArray.forEach((file) => {
    formData.append(`item[images][]`, file);
  });

  fetch(form.action, {
    method: form.method,
    body: formData,
    headers: {
      'X-CSRF-Token': document.querySelector('meta[name="csrf-token"]').getAttribute('content'),
    },
  })
  .then((response) => {
    if (response.ok) {
      console.log('Form submitted successfully');
      // Handle successful submission (e.g., redirect or show a success message)
    } else {
      console.error('Form submission failed');
      // Handle errors (e.g., display an error message)
    }
  })
  .catch((error) => {
    console.error('Error submitting form:', error);
  });
}
