function resetField(field) {
  if (field) {
    field.classList.add('hidden');
    field.required = false;
    field.value = '';
  }
}
