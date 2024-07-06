document.addEventListener('turbolinks:load', () => {
  const imageUpload = document.getElementById('image-upload');
  const imagePreview = document.getElementById('image-preview');
  const form = document.querySelector('form');
  let filesArray = [];

  if (imageUpload) {
    imageUpload.addEventListener('change', handleFileSelect);
  }

  if (form) {
    form.addEventListener('submit', handleFormSubmit);
  }

  function handleFileSelect(event) {
    const newFiles = Array.from(event.target.files);

    // Add new files to the files array
    filesArray = filesArray.concat(newFiles);

    // Clear previous previews
    imagePreview.innerHTML = '';

    // Loop through the files array and create an image element for each one
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

        removeButton.addEventListener('click', handleRemove);

        imgElement.appendChild(img);
        imgElement.appendChild(removeButton);
        imagePreview.appendChild(imgElement);
      };

      // Read the file as a data URL
      reader.readAsDataURL(file);
    });

    // Clear the file input value to allow selecting the same file again
    event.target.value = '';
  }

  function handleRemove(event) {
    const index = parseInt(event.target.dataset.index, 10);
    filesArray.splice(index, 1);

    // Re-render the previews
    imagePreview.innerHTML = '';
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

        removeButton.addEventListener('click', handleRemove);

        imgElement.appendChild(img);
        imgElement.appendChild(removeButton);
        imagePreview.appendChild(imgElement);
      };

      reader.readAsDataURL(file);
    });
  }

  function handleFormSubmit(event) {
    const formData = new FormData(form);

    // Append all selected files to the form data
    filesArray.forEach((file) => {
      formData.append(`item[images][]`, file);
    });

    // Send the form data via AJAX or submit the form normally
    // Example of submitting the form via AJAX:
    fetch(form.action, {
      method: form.method,
      body: formData,
      headers: {
        'X-CSRF-Token': document.querySelector('meta[name="csrf-token"]').getAttribute('content')
      }
    }).then(response => {
      // Handle the response
      if (response.ok) {
        // Handle successful submission
      } else {
        // Handle errors
      }
    });

    // Prevent the default form submission
    event.preventDefault();
  }
});
