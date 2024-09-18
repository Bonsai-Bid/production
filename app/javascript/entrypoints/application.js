// app/javascript/entrypoints/application.js

import Rails from '@rails/ujs';
import Turbolinks from 'turbolinks';
import * as ActiveStorage from '@rails/activestorage';
import './application.css'; // Using Tailwind CSS file

Rails.start();
Turbolinks.start();
ActiveStorage.start();


// document.addEventListener('turbolinks:load', setCSRFToken);

import '../category_initialization';
import '../attribute_initialization';
import '../form_submission';
import '../auction_initialization';
import '../image_initialization';
import '../list_later';
import '../user_profile';
import '../countdown';
import '../buy_now_reserve';
import '../form_conditionals';
