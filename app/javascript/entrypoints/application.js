// app/javascript/entrypoints/application.js

import Rails from '@rails/ujs';
import Turbolinks from 'turbolinks';
import * as ActiveStorage from '@rails/activestorage';
import './application.css'; // Using Tailwind CSS file

Rails.start();
Turbolinks.start();
ActiveStorage.start();

import '../category_initialization';
import '../attribute_initialization';
import '../form_submission';
import '../auction_initialization';
import '../other_initialization';
import '../user_profile';
