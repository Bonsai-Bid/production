# spec/features/user_registration/email_validations_spec.rb
require 'rails_helper'

RSpec.feature 'User Registration - Email Validations', type: :feature, js: true do
  before do
    # Register the headful mode driver specifically for these tests
    Capybara.register_driver :selenium_chrome_headful do |app|
      options = Selenium::WebDriver::Chrome::Options.new
      # Remove headless argument to enable headful mode
      options.add_argument('--disable-gpu')
      options.add_argument('--window-size=1400,1400')

      Capybara::Selenium::Driver.new(
        app,
        browser: :chrome,
        options: options
      )
    end

    # Set the JavaScript driver to headful mode just for these tests
    Capybara.javascript_driver = :selenium_chrome_headful

    visit new_user_registration_path
  end

  after do
    # Reset the JavaScript driver back to default to avoid affecting other tests
    Capybara.javascript_driver = :selenium_chrome
  end

  def check_email_validation_message(email)
    fill_in 'Email', with: email
    # Trigger the validation bubble by forcing validation
    page.execute_script("document.querySelector('input[type=email]').reportValidity();")
    valid = page.evaluate_script("document.querySelector('input[type=email]').checkValidity();")
    validation_message = page.evaluate_script("document.querySelector('input[type=email]').validationMessage;")
    
    [valid, validation_message]
  end

  scenario 'User fails to register with invalid email format (missing "@")' do
    fill_in 'First name', with: 'John'
    fill_in 'Last name', with: 'Doe'
    valid, validation_message = check_email_validation_message('invalid')
    
    # Assert that the email field is invalid and the correct validation message is shown
    expect(valid).to be false
    expect(validation_message).to eq "Please include an '@' in the email address. 'invalid' is missing an '@'."

    # No further form submission or backend validation expected
  end

  scenario 'User fails to register with invalid email format (missing domain)' do
    fill_in 'First name', with: 'John'
    fill_in 'Last name', with: 'Doe'
    valid, validation_message = check_email_validation_message('user@')
    
    # Assert that the email field is invalid and the correct validation message is shown
    expect(valid).to be false
    expect(validation_message).to include('Please enter a part following \'@\'.')

    # No further form submission or backend validation expected
  end

  def check_email_validation_message(email)
    fill_in 'Email', with: email
    page.execute_script("document.querySelector('input[type=email]').reportValidity();")
    valid = page.evaluate_script("document.querySelector('input[type=email]').checkValidity();")
    validation_message = page.evaluate_script("document.querySelector('input[type=email]').validationMessage;")
    
    [valid, validation_message]
  end

  scenario 'User registers with a valid but uncommon email format' do
    fill_in 'First name', with: 'John'
    fill_in 'Last name', with: 'Doe'
    valid, validation_message = check_email_validation_message('user+alias@example.com')
    expect(valid).to be true
    expect(validation_message).to eq '' # No validation message expected

    fill_in 'Phone', with: '123-456-7890'
    fill_in 'Password', with: 'password123!'
    fill_in 'Confirm Password', with: 'password123!'
    fill_in 'Street', with: '123 Elm St'
    fill_in 'City', with: 'Anytown'
    select 'California', from: 'State'
    fill_in 'Zip', with: '12345'
    select 'Pacific Time (US & Canada)', from: 'Time zone'
    
    click_button 'Sign Up'
    expect(page).to have_content('Welcome! You have signed up successfully.')
  end

  scenario 'User enters email exceeding maximum length' do
    visit new_user_registration_path
  
    # Email length exceeds 255 characters
    long_email = "#{'a' * 244}@example.com"  # Total length 255 characters
  
    # Use JavaScript to bypass the maxlength constraint on the input field
    page.execute_script("document.getElementById('user_email').value = '#{long_email}';")
  
    fill_in 'First name', with: 'John'
    fill_in 'Last name', with: 'Doe'
    fill_in 'Phone', with: '123-456-7890'
    fill_in 'Password', with: 'password123!'
    fill_in 'Confirm Password', with: 'password123!'
    fill_in 'Street', with: '123 Elm St'
    fill_in 'City', with: 'Anytown'
    select 'California', from: 'State'
    fill_in 'Zip', with: '12345'
    select 'Pacific Time (US & Canada)', from: 'Time zone'
    
    click_button 'Sign Up'
  
    # Expect the error message from server-side validation
    expect(page).to have_content('Email is too long')  # Example error message
  end
  
end
