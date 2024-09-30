import Rails from '@rails/ujs';
import Turbolinks from 'turbolinks';
import * as ActiveStorage from '@rails/activestorage';

// Import specific modules from the 'modules' directory
import { initializeFormSubmission } from '../modules/forms/initializeFormSubmission';
import { initializeCategorySelect } from '../modules/visibility/initializeCategorySelect';
import { initializeOtherField } from '../modules/visibility/initializeOtherField';
import { initializeImageUpload } from '../modules/imageUpload/initializeImageUpload';
import { initializeCountdown } from '../modules/initialization/initializeCountdown';
import { handleCategoryVisibility } from '../modules/visibility/handleCategoryVisibility';

// Initialize Rails, Turbolinks, and ActiveStorage
Rails.start();
Turbolinks.start();
ActiveStorage.start();

// Turbolinks: load event to ensure all features re-initialize on page change
document.addEventListener('turbolinks:load', () => {
  console.log("Turbolinks page load");
  

  const form = document.querySelector('form');
  if (form) {
    initializeFormSubmission(form);
  }

  const categorySelect = document.getElementById('item_category_type');
  if (categorySelect) {
    console.log("Category select element found:", categorySelect.value);
    initializeCategorySelect(categorySelect);
    categorySelect.addEventListener('change', () => {
      console.log("Category changed to:", categorySelect.value);
      handleCategoryVisibility(categorySelect.value); // Handle visibility for the newly selected category
    });
  } else {
    console.error("Category select element not found");
  }

  const otherElement = document.getElementById('some_other_field'); // Replace with actual ID
  if (otherElement) {
    initializeOtherField(otherElement);
  }

  const imageUpload = document.getElementById('image-upload');
  if (imageUpload) {
    initializeImageUpload(imageUpload);
  }

  const countdownElement = document.querySelector('[data-end-date]');
  if (countdownElement) {
    initializeCountdown(countdownElement);
  }
});
