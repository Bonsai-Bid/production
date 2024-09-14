document.addEventListener('turbolinks:load', function() {
  // Select the radio buttons
  const listNowRadio = document.getElementById('list_now');
  const listLaterRadio = document.getElementById('list_later');

  // Select the container that holds the fields to show/hide
  const listLaterFields = document.getElementById('list_later_fields');

  // Function to toggle visibility based on the radio button selected
  function toggleListLaterFields() {
    if (listLaterRadio.checked) {
      listLaterFields.style.display = 'block';
    } else {
      listLaterFields.style.display = 'none';
    }
  }

  // Event listeners for changes on the radio buttons
  listNowRadio.addEventListener('change', toggleListLaterFields);
  listLaterRadio.addEventListener('change', toggleListLaterFields);

  // Initial check to set the correct display on page load
  toggleListLaterFields();
});
