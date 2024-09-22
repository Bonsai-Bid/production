// import { handleRemove } from './handleRemove';

// let filesArray = [];

// export const handleFileSelect = (event) => {
//   const imagePreview = document.getElementById('image-preview');
//   const newFiles = Array.from(event.target.files);

//   // Add new files to the files array
//   filesArray = filesArray.concat(newFiles);

//   // Clear previous previews
//   imagePreview.innerHTML = '';

//   // Loop through the files array and create an image element for each one
//   filesArray.forEach((file, index) => {
//     const reader = new FileReader();
//     reader.onload = (e) => {
//       const imgElement = document.createElement('div');
//       imgElement.classList.add('relative', 'h-24', 'w-24', 'm-2');

//       const img = document.createElement('img');
//       img.src = e.target.result;
//       img.classList.add('h-full', 'w-full', 'object-cover', 'border', 'rounded');

//       const removeButton = document.createElement('button');
//       removeButton.innerHTML = '&times;';
//       removeButton.classList.add('absolute', 'top-0', 'right-0', 'bg-red-500', 'text-white', 'rounded-full', 'h-6', 'w-6', 'flex', 'items-center', 'justify-center', 'cursor-pointer');
//       removeButton.dataset.index = index;

//       removeButton.addEventListener('click', handleRemove);

//       imgElement.appendChild(img);
//       imgElement.appendChild(removeButton);
//       imagePreview.appendChild(imgElement);
//     };

//     // Read the file as a data URL
//     reader.readAsDataURL(file);
//   });

//   // Clear the file input value to allow selecting the same file again
//   event.target.value = '';
// };

// export const getFilesArray = () => filesArray;
// export const setFilesArray = (newFilesArray) => {
//   filesArray = newFilesArray;
// };
