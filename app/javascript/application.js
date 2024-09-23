// app/javascript/application.js

// Import core dependencies that should be globally available across the entire app
import Rails from '@rails/ujs';
import Turbolinks from 'turbolinks';
import * as ActiveStorage from '@rails/activestorage';
import './application.css'; // Global CSS like Tailwind

// Initialize Rails UJS, Turbolinks, and ActiveStorage globally
Rails.start();
Turbolinks.start();
ActiveStorage.start();

// Any other global utilities or configuration settings
// Example: You could set up any global variables, polyfills, or configurations here

console.log('Global application.js is loaded');

// Optionally export modules for use elsewhere if needed
