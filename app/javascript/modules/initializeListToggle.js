export function initializeListToggle() {
  const listNowRadio = document.getElementById('list_now');
  const listLaterRadio = document.getElementById('list_later');
  const listLaterFields = document.getElementById('list_later_fields');

  if (listNowRadio && listLaterRadio && listLaterFields) {
    function toggleListLaterFields() {
      if (listLaterRadio.checked) {
        listLaterFields.style.display = 'block';
      } else {
        listLaterFields.style.display = 'none';
      }
    }

    listNowRadio.addEventListener('change', toggleListLaterFields);
    listLaterRadio.addEventListener('change', toggleListLaterFields);

    toggleListLaterFields();
  }
}
