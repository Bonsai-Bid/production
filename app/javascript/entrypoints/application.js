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
import { setupSelect } from '../modules/visibility/setupSelect';
import { showOtherField } from '../modules/visibility/showOtherField';
import { toggleVisibility } from '../modules/visibility/toggleVisibility';

// Ensure that everything re-initializes properly on Turbolinks page load
document.addEventListener('turbolinks:load', () => {
  // Initialize forms
  handleFormSubmit();
  initializeFormSubmission();
  prepareFormForSubmission();
  clearFormFields(); // Added
  resetFields(); // Added

  // Initialize image upload features
  createImagePreview();
  handleFileSelect();
  initializeImageUpload(); // Added
  updateImagePreview(); // Added

  // Initialize general page components and attributes
  initializeAttributes();
  initializeBuyNowReserve();
  initializeCountdown();
  initializeListToggle(); // Added
  initializePageComponents();
  initializeTabs();
  updateCountdown();

  // Initialize visibility logic
  handleCategoryChange();
  handleCategoryVisibility();
  handleEssentialTypeVisibility();
  setupSelect();
  showOtherField();
  toggleVisibility();
});



// Other imports for user profile, conditionals, etc., as needed
import '../user_profile';
// import '../buy_now_reserve';
// import '../form_conditionals';

// CSS for Tailwind
// import '../application.css';
