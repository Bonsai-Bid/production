// export async function handleFormSubmit(event) {
//   if (!event) {
//     console.error("No event detected. Is the form element correct?");
//     return;
//   }
//   event.preventDefault();

//   const form = event.target;
//   const method = form.method.toUpperCase();
  
//   if (method === 'GET' || method === 'HEAD') {
//     return;
//   }

//   const formData = new FormData(form);
//   console.log("Form data before submission:", Object.fromEntries(formData)); // Log all form data before submission

//   // Append files to form data, if applicable
//   if (filesArray.length > 0) {
//     filesArray.forEach(file => formData.append('item[images][]', file));
//   }

//   try {
//     const response = await fetch(form.action, {
//       method,
//       body: formData,
//       headers: {
//         'X-CSRF-Token': document.querySelector('meta[name="csrf-token"]').getAttribute('content'),
//       },
//     });

//     if (response.ok) {
//       console.log('Form submitted successfully');
//       // Add any success handling here (e.g., redirect, success message)
//     } else {
//       console.error('Form submission failed');
//       // Handle submission error (e.g., error message)
//     }
//   } catch (error) {
//     console.error('Error submitting form:', error);
//     // Handle network error (e.g., error message)
//   }
// }
