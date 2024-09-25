// document.addEventListener('turbolinks:load', () => {
//   const imageUpload = document.getElementById('image-upload');
//   const imagePreview = document.getElementById('image-preview');
//   const form = document.querySelector('form');
//   let filesArray = [];

//   if (imageUpload) {
//     imageUpload.addEventListener('change', handleFileSelect);
//   }

//   if (form) {
//     form.addEventListener('submit', handleFormSubmit);
//   }

//   function handleFileSelect(event) {
//     const newFiles = Array.from(event.target.files);

//     // Add new files to the files array
//     filesArray = filesArray.concat(newFiles);

//     // Clear previous previews
//     imagePreview.innerHTML = '';

//     // Loop through the files array and create an image element for each one
//     filesArray.forEach((file, index) => {
//       const reader = new FileReader();
//       reader.onload = (e) => {
//         const imgElement = document.createElement('div');
//         imgElement.classList.add('relative', 'h-24', 'w-24', 'm-2');

//         const img = document.createElement('img');
//         img.src = e.target.result;
//         img.classList.add('h-full', 'w-full', 'object-cover', 'border', 'rounded');

//         const removeButton = document.createElement('button');
//         removeButton.innerHTML = '&times;';
//         removeButton.classList.add('absolute', 'top-0', 'right-0', 'bg-red-500', 'text-white', 'rounded-full', 'h-6', 'w-6', 'flex', 'items-center', 'justify-center', 'cursor-pointer');
//         removeButton.dataset.index = index;

//         removeButton.addEventListener('click', handleRemove);

//         imgElement.appendChild(img);
//         imgElement.appendChild(removeButton);
//         imagePreview.appendChild(imgElement);
//       };

//       // Read the file as a data URL
//       reader.readAsDataURL(file);
//     });

//     // Clear the file input value to allow selecting the same file again
//     event.target.value = '';
//   }

//   function handleRemove(event) {
//     const index = parseInt(event.target.dataset.index, 10);
//     filesArray.splice(index, 1);

//     // Re-render the previews
//     imagePreview.innerHTML = '';
//     filesArray.forEach((file, index) => {
//       const reader = new FileReader();
//       reader.onload = (e) => {
//         const imgElement = document.createElement('div');
//         imgElement.classList.add('relative', 'h-24', 'w-24', 'm-2');

//         const img = document.createElement('img');
//         img.src = e.target.result;
//         img.classList.add('h-full', 'w-full', 'object-cover', 'border', 'rounded');

//         const removeButton = document.createElement('button');
//         removeButton.innerHTML = '&times;';
//         removeButton.classList.add('absolute', 'top-0', 'right-0', 'bg-red-500', 'text-white', 'rounded-full', 'h-6', 'w-6', 'flex', 'items-center', 'justify-center', 'cursor-pointer');
//         removeButton.dataset.index = index;

//         removeButton.addEventListener('click', handleRemove);

//         imgElement.appendChild(img);
//         imgElement.appendChild(removeButton);
//         imagePreview.appendChild(imgElement);
//       };

//       reader.readAsDataURL(file);
//     });
//   }

//   function handleFormSubmit(event) {
//     const method = form.method.toUpperCase();

//     // Only prevent default submission for forms that are not GET or HEAD
//     if (method !== 'GET' && method !== 'HEAD') {
//       event.preventDefault(); // Prevent the default form submission

//       const formData = new FormData(form);

//       // Append all selected files to the form data
//       filesArray.forEach((file) => {
//         formData.append(`item[images][]`, file);
//       });

//       // Send the form data via AJAX with the correct method
//       fetch(form.action, {
//         method: method, // Use the form's method
//         body: formData, // Only include body if the method is not GET/HEAD
//         headers: {
//           'X-CSRF-Token': document.querySelector('meta[name="csrf-token"]').getAttribute('content')
//         }
//       }).then(response => {
//         // Handle the response
//         if (response.ok) {
//           // Handle successful submission (e.g., redirect or show a success message)
//           console.log('Form submitted successfully');
//         } else {
//           // Handle errors (e.g., display an error message)
//           console.error('Form submission failed');
//         }
//       }).catch(error => {
//         // Handle fetch errors (e.g., network issues)
//         console.error('Error submitting form:', error);
//       });
//     }
//   }
// });
