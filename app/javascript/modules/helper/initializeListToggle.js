export function initializeListToggle() {
  const listNowRadio = document.getElementById('list_now');
  const listLaterRadio = document.getElementById('list_later');
  const listLaterFields = document.getElementById('list_later_fields');

  const toggleFields = () => {
    listLaterFields.style.display = listLaterRadio.checked ? 'block' : 'none';
  };

  if (listNowRadio && listLaterRadio) {
    listNowRadio.addEventListener('change', toggleFields);
    listLaterRadio.addEventListener('change', toggleFields);
    toggleFields(); // Initial state setup
  }
}
