// app/javascript/packs/auction_timing.js
document.addEventListener('turbolinks:load', () => {
  const listNowRadio = document.getElementById('list_now');
  const listLaterRadio = document.getElementById('list_later');
  const listNowFields = document.getElementById('list_now_fields');
  const listLaterFields = document.getElementById('list_later_fields');
  const toggleEndTimeButton = document.getElementById('toggle_end_time');
  const endTimeFields = document.getElementById('end_time_fields');

  const toggleFields = () => {
    if (listNowRadio.checked) {
      listNowFields.classList.remove('hidden');
      listLaterFields.classList.add('hidden');
    } else if (listLaterRadio.checked) {
      listNowFields.classList.add('hidden');
      listLaterFields.classList.remove('hidden');
    }
  };

  const toggleEndTimeFields = () => {
    endTimeFields.classList.toggle('hidden');
  };

  listNowRadio.addEventListener('change', toggleFields);
  listLaterRadio.addEventListener('change', toggleFields);
  toggleEndTimeButton.addEventListener('click', toggleEndTimeFields);

  // Initialize the fields based on the current selection
  toggleFields();
});
