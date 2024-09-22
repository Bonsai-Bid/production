export function clearFormFields(container) {
  const inputs = container?.querySelectorAll('input, select, textarea');
  inputs?.forEach(input => {
    input.value = '';
    input.required = false;
  });
}
