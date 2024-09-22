import { toggleListLaterFields } from './toggleListLaterFields';

export function initializeListToggle() {
  const listNowRadio = document.getElementById('list_now');
  const listLaterRadio = document.getElementById('list_later');
  const listLaterFields = document.getElementById('list_later_fields');

  if (listNowRadio && listLaterRadio && listLaterFields) {
    // Initial check to set the correct display on page load
    toggleListLaterFields(listLaterRadio, listLaterFields);

    // Event listeners for changes on the radio buttons
    listNowRadio.addEventListener('change', () => toggleListLaterFields(listLaterRadio, listLaterFields));
    listLaterRadio.addEventListener('change', () => toggleListLaterFields(listLaterRadio, listLaterFields));
  }
}
