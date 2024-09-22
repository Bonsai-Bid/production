// Entry point for the build script in your package.json
import "@hotwired/turbo-rails"
import "./controllers"

// Import necessary modules
import { initializeAttributes } from './modules/initializeAttributes';
import { initializeImageUpload } from './modules/initializeImageUpload';
import { initializeFormSubmission } from './modules/initializeFormSubmission';
import { initializeCategorySelection } from './modules/initializeCategorySelection';
import { initializeListToggle } from './modules/initializeListToggle';
import { initializeCountdown } from './modules/initializeCountdown';
import { initializeBuyItNow } from './modules/initializeBuyItNow';
import { initializeReservePrice } from './modules/initializeReservePrice';
import { initializeTabs } from './modules/initializeTabs';

document.addEventListener('turbo:load', () => {
  initializeAttributes();
  initializeImageUpload();
  initializeFormSubmission();
  initializeCategorySelection();
  initializeListToggle();
  initializeCountdown();
  initializeBuyItNow();
  initializeReservePrice();
  initializeTabs();
});
