export function toggleFieldVisibility(selectedCategory, plantFields, containerFields, essentialFields) {
  if (plantFields) plantFields.classList.add('hidden');
  if (containerFields) containerFields.classList.add('hidden');
  if (essentialFields) essentialFields.classList.add('hidden');

  if (selectedCategory === 'plant' || selectedCategory === '3') {
    if (plantFields) plantFields.classList.remove('hidden');
    if (containerFields) containerFields.classList.remove('hidden');
  } else if (selectedCategory === 'container' || selectedCategory === '1') {
    if (containerFields) containerFields.classList.remove('hidden');
  } else if (selectedCategory === 'essential' || selectedCategory === '2') {
    if (essentialFields) essentialFields.classList.remove('hidden');
  }
}
