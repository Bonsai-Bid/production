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

// Prevent re-initialization of listeners
let isInitialized = false;

// Turbolinks: load event to ensure all features re-initialize on page change
document.addEventListener('turbolinks:load', () => {
  console.log("Handling visibility triggered by Turbolinks page load");

  // Initialize form submission logic
  const form = document.querySelector('form');
  if (form) {
    initializeFormSubmission(form);
  }

  // Category select handling and visibility management
  const categorySelect = document.getElementById('item_category_type');
  
  if (categorySelect && !isInitialized) {
    console.log("Category select element found:", categorySelect.value);
    
    // Only trigger visibility logic if the category value is not already set (to avoid redundancy)
    if (!categorySelect.value) {
      handleCategoryVisibility(categorySelect.value); // Handle visibility on page load if no category is preselected
    }

    // Add the event listener for category changes
    categorySelect.addEventListener('change', () => {
      console.log("Handling visibility triggered by manual category change");
      handleCategoryVisibility(categorySelect.value); // Handle visibility for the newly selected category
    });

    // Mark initialization as completed to prevent reinitialization
    isInitialized = true;
  } else if (!categorySelect) {
    console.error("Category select element not found");
  }

  // Initialize "Other" field handling (replace ID with actual value)
  const otherElement = document.getElementById('some_other_field');
  if (otherElement) {
    initializeOtherField(otherElement);
  }

  // Image upload logic
  const imageUpload = document.getElementById('image-upload');
  if (imageUpload) {
    initializeImageUpload(imageUpload);
  }

  // Countdown initialization for auction items
  const countdownElement = document.querySelector('[data-end-date]');
  if (countdownElement) {
    initializeCountdown(countdownElement);
  }
});
