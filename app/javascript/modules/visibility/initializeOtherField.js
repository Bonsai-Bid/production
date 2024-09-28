export function initializeOtherField(selectElement, otherElementId) {
  if (!selectElement) {
    console.error("Select element is undefined or null.");
    return;
  }

  const otherElement = document.getElementById(otherElementId);
  if (!otherElement) {
    console.error(`Other element with ID ${otherElementId} not found.`);
    return;
  }

  // Helper function to show or hide the "Other" field
  function toggleOtherFieldVisibility() {
    const selectedValue = selectElement.value;
    const shouldShowOtherField = selectedValue === 'other'; // Adjust this as needed

    // Show or hide the 'Other' field
    otherElement.classList.toggle('hidden', !shouldShowOtherField);
    otherElement.required = shouldShowOtherField;

    // Optionally clear the value when hiding the field
    if (!shouldShowOtherField) {
      otherElement.value = ''; 
    }

    console.log(`Toggling 'Other' field visibility: ${shouldShowOtherField ? 'Shown' : 'Hidden'}`);
  }

  // Initialize visibility on page load
  toggleOtherFieldVisibility();

  // Add an event listener to the select element to react to changes
  selectElement.addEventListener('change', toggleOtherFieldVisibility);
}
