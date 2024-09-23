// Shows the "Other" field when selected
function showOtherField(otherElement) {
  otherElement.classList.remove('hidden');
  otherElement.removeAttribute('aria-hidden');
  otherElement.required = true;
}