import { prepareFormForSubmission } from './prepareFormForSubmission';

export function initializeFormSubmission(fieldsToConvert) {
  const form = document.querySelector('form');
  if (form) {
    form.addEventListener('submit', (event) => {
      prepareFormForSubmission(fieldsToConvert, form);
    });
  }
}
