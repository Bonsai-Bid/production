export function convertFieldsToInt(fieldsToConvert) {
  fieldsToConvert.forEach(fieldId => {
    const field = document.getElementById(fieldId);
    if (field && field.value !== '') {
      field.value = parseInt(field.value, 10);
    }
  });
}
