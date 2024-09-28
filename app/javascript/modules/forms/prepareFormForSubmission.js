export function prepareFormForSubmission(fieldsToConvert, form) {
  if (!fieldsToConvert || fieldsToConvert.length === 0) {
    console.error("No fields provided to convert.");
    return;
  }
  // Convert specified fields to integers
  fieldsToConvert.forEach(fieldId => {
    const field = document.getElementById(fieldId);
    if (field && field.value !== '') {
      const value = parseInt(field.value, 10);
      field.value = isNaN(value) ? '' : value;
    }
  });

  // Disable empty fields
  const optionalFields = form.querySelectorAll('input[type="text"], select');
  optionalFields.forEach(field => {
    if (field.value === '') {
      field.disabled = true;
    }
  });
}
