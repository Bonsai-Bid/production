// export function handleFormSubmit(event, form, filesArray) {
//   const method = form.method.toUpperCase();

//   // Only prevent default submission for forms that are not GET or HEAD
//   if (method !== 'GET' && method !== 'HEAD') {
//     event.preventDefault(); // Prevent the default form submission

//     const formData = new FormData(form);

//     // Append all selected files to the form data
//     filesArray.forEach((file) => {
//       formData.append(`item[images][]`, file);
//     });

//     // Send the form data via AJAX with the correct method
//     fetch(form.action, {
//       method: method, // Use the form's method
//       body: formData, // Only include body if the method is not GET/HEAD
//       headers: {
//         'X-CSRF-Token': document.querySelector('meta[name="csrf-token"]').getAttribute('content')
//       }
//     }).then(response => {
//       // Handle the response
//       if (response.ok) {
//         // Handle successful submission (e.g., redirect or show a success message)
//         console.log('Form submitted successfully');
//       } else {
//         // Handle errors (e.g., display an error message)
//         console.error('Form submission failed');
//       }
//     }).catch(error => {
//       // Handle fetch errors (e.g., network issues)
//       console.error('Error submitting form:', error);
//     });
//   }
// }
