// app/frontend/javascripts/image_preview.js
document.addEventListener('DOMContentLoaded', () => {
  const imageUpload = document.getElementById('image-upload');
  const imagePreview = document.getElementById('image-preview');

  imageUpload.addEventListener('change', handleFileSelect);

  function handleFileSelect(event) {
    const files = event.target.files;

    // Clear previous previews
    imagePreview.innerHTML = '';

    // Loop through the files and create an image element for each one
    Array.from(files).forEach(file => {
      const reader = new FileReader();
      reader.onload = (e) => {
        const imgElement = document.createElement('img');
        imgElement.src = e.target.result;
        imgElement.classList.add('h-24', 'w-24', 'object-cover', 'm-2', 'border', 'rounded');

        // Append the image element to the preview container
        imagePreview.appendChild(imgElement);
      };

      // Read the file as a data URL
      reader.readAsDataURL(file);
    });
  }
});
