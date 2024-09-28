// app/javascript/entrypoints/application.js

// Core Rails imports
import Rails from '@rails/ujs';
import Turbolinks from 'turbolinks';
import * as ActiveStorage from '@rails/activestorage';
import './application.css'; // Using Tailwind CSS file

// Initialize Rails, Turbolinks, and ActiveStorage
Rails.start();
Turbolinks.start();
ActiveStorage.start();

// Import specific modules from 'forms'
import { handleFormSubmit } from '../modules/forms/handleFormSubmit';
import { initializeFormSubmission } from '../modules/forms/initializeFormSubmission';
import { prepareFormForSubmission } from '../modules/forms/prepareFormForSubmission';
import { clearFormFields } from '../modules/helper/clearFormFields'; // Added
import { resetFields } from '../modules/visibility/resetFields'; // Added

// Import specific modules from 'imageUpload'
import { createImagePreview } from '../modules/imageUpload/createImagePreview';
import { handleFileSelect } from '../modules/imageUpload/handleFileSelect';
import { initializeImageUpload } from '../modules/imageUpload/initializeImageUpload'; // Added
import { updateImagePreview } from '../modules/imageUpload/updateImagePreview'; // Added

// Import specific modules from 'initialization'
import { initializeAttributes } from '../modules/initialization/initializeAttributes';
import { initializeBuyNowReserve } from '../modules/initialization/initializeBuyNowReserve';
import { initializeCountdown } from '../modules/initialization/initializeCountdown';
import { initializeListToggle } from '../modules/initialization/initializeListToggle'; // Added
import { initializePageComponents } from '../modules/initialization/initializePageComponents';
import { initializeTabs } from '../modules/initialization/initializeTabs';
import { updateCountdown } from '../modules/initialization/updateCountdown';

// Import specific modules from 'visibility'
import { handleCategoryChange } from '../modules/visibility/handleCategoryChange';
import { handleCategoryVisibility } from '../modules/visibility/handleCategoryVisibility';
import { handleEssentialTypeVisibility } from '../modules/visibility/handleEssentialTypeVisibility';
import { handleSelectChange } from '../modules/visibility/handleSelectChange';
import { setupSelect } from '../modules/visibility/setupSelect';
import { toggleVisibility } from '../modules/visibility/toggleVisibility';

// Ensure that everything re-initializes properly on Turbolinks page load
document.addEventListener('turbolinks:load', () => {
  console.log("Turbolinks page load");

  // Form submission handling
  const form = document.querySelector('form');
  if (form) {
    form.addEventListener('submit', handleFormSubmit);

    const fieldsToConvert = ['field1', 'field2']; // Replace with actual field IDs
    initializeFormSubmission(fieldsToConvert);
    prepareFormForSubmission(fieldsToConvert, form);
  }

  // Category select handling (item_category_type)
  const categorySelect = document.getElementById('item_category_type');
  if (categorySelect) {
    console.log("Category select initialized:", categorySelect);
    categorySelect.addEventListener('change', () => handleCategoryChange(categorySelect));
    handleCategoryChange(categorySelect); // Initialize visibility logic on page load
  } else {
    console.error("Category select element not found.");
  }

  // Handling "Other" fields
  const otherElement = document.getElementById('some_other_field'); // Replace with your actual ID
  if (otherElement) {
    console.log('Other element found:', otherElement);
    // Add any additional handling for "Other" fields here
  } else {
    console.error('Other element is not found in the DOM.');
  }

  // Initialize image upload features (if the input exists)
  const imageUpload = document.getElementById('image-upload');
  if (imageUpload) {
    initializeImageUpload();
  } else {
    console.error("Image upload input not found.");
  }

  // Initialize countdown if the element with data-end-date exists
  const countdownElement = document.querySelector('[data-end-date]');
  if (countdownElement) {
    updateCountdown(countdownElement);
  } else {
    console.error("Countdown element with data-end-date not found.");
  }

  // General page component initialization
  clearFormFields();
  resetFields();
  createImagePreview();
  updateImagePreview();
  handleFileSelect();
  handleSelectChange();

  initializeAttributes();
  initializeBuyNowReserve();
  initializeListToggle();
  initializePageComponents();
  initializeTabs();
  setupSelect(); // Handles dynamic selects
  toggleVisibility(); // General visibility toggling
});

// Other imports for user profile, conditionals, etc., as needed
import '../user_profile';
// import '../buy_now_reserve';
// import '../form_conditionals';

// CSS for Tailwind
// import '../application.css';
