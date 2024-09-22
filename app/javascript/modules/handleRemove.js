// Helper functions that were previously imported from 2handleFileSelect
let filesArray = [];

export function getFilesArray() {
  return filesArray;
}

export function setFilesArray(newArray) {
  filesArray = newArray;
}

export function handleRemove(event) {
  // Get the current files array
  let filesArray = getFilesArray();

  const index = parseInt(event.target.dataset.index, 10);
  filesArray.splice(index, 1); // Remove the selected file from the array

  // Update the files array
  setFilesArray(filesArray);

  const imagePreview = document.getElementById('image-preview');
  imagePreview.innerHTML = ''; // Clear previous previews

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

      // Rebind the remove button to call handleRemove for the new index
      removeButton.addEventListener('click', handleRemove);

      imgElement.appendChild(img);
      imgElement.appendChild(removeButton);
      imagePreview.appendChild(imgElement);
    };

    reader.readAsDataURL(file); // Read the file as a data URL for preview
  });
}
