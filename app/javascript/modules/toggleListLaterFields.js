export function toggleListLaterFields(listLaterRadio, listLaterFields) {
  if (listLaterRadio.checked) {
    listLaterFields.style.display = 'block';
  } else {
    listLaterFields.style.display = 'none';
  }
}
