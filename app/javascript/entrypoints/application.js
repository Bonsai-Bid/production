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

// Ensure that everything re-initializes properly on Turbolinks page load
document.addEventListener('turbolinks:load', () => {
  // Initialize any additional JavaScript that needs to re-run after navigation
  initializeFormSubmission(['price', 'quantity']);
  initializeImageUpload();
  initializeAttributes();
  initializeCountdown();
  initializeListToggle();
  initializePageComponents();
});

// Import application-specific modules
import { initializeFormSubmission } from '../form_submission'; // Adjust paths as needed
import { initializeImageUpload } from '../image_initialization';
import { initializeAttributes } from '../attribute_initialization';
import { initializeCountdown } from '../countdown';
import { initializeListToggle } from '../list_later';
import { initializePageComponents } from '../auction_initialization'; // Assuming it includes auction-related component logic

// Other imports for user profile, conditionals, etc., as needed
import '../user_profile';
// import '../buy_now_reserve';
// import '../form_conditionals';

// CSS for Tailwind
// import '../application.css';
