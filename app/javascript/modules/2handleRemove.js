import { getFilesArray, setFilesArray } from './2handleFileSelect';

export const handleRemove = (event) => {
  const imagePreview = document.getElementById('image-preview');
  const index = parseInt(event.target.dataset.index, 10);
  let filesArray = getFilesArray();

  // Remove the file from the array
  filesArray.splice(index, 1);
  setFilesArray(filesArray);

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
};
