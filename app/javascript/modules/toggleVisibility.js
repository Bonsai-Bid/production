export function toggleVisibility(checkbox, field) {
  checkbox.addEventListener('change', () => {
    if (checkbox.checked) {
      field.classList.remove('hidden');
    } else {
      field.classList.add('hidden');
    }
  });

  // Set initial visibility based on the checkbox state
  if (checkbox.checked) {
    field.classList.remove('hidden');
  } else {
    field.classList.add('hidden');
  }
}
