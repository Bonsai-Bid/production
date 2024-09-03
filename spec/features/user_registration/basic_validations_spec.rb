# spec/features/user_registration/basic_validations_spec.rb
require 'rails_helper'

RSpec.feature 'User Registration - Basic Validations', type: :feature, js: true do
  before do
    # Register the headful mode driver specifically for these tests
    Capybara.register_driver :selenium_chrome_headful do |app|
      options = Selenium::WebDriver::Chrome::Options.new
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

  def check_validation_message(field, expected_message)
    # Trigger the validation bubble by forcing validation on the field
    page.execute_script("document.getElementById('#{field}').reportValidity();")
    validation_message = page.evaluate_script("document.getElementById('#{field}').validationMessage;")
    
    validation_message == expected_message
  end

  scenario 'User fails to register with missing first name' do
    fill_in 'Last name', with: 'Doe'
    fill_in 'Email', with: 'test@example.com'
    fill_in 'Phone', with: '123-456-7890'
    fill_in 'Password', with: 'password123!'
    fill_in 'Confirm Password', with: 'password123!'
    fill_in 'Street', with: '123 Elm St'
    fill_in 'City', with: 'Anytown'
    select 'California', from: 'State'
    fill_in 'Zip', with: '12345'
    select 'Pacific Time (US & Canada)', from: 'Time zone'

    click_button 'Sign Up'

    # Client-side validation: Check the browser validation message
    expect(check_validation_message('user_first_name', 'Please fill out this field.')).to be true
  end

  scenario 'User fails to register with missing last name' do
    fill_in 'First name', with: 'John'
    fill_in 'Email', with: 'test@example.com'
    fill_in 'Phone', with: '123-456-7890'
    fill_in 'Password', with: 'password123!'
    fill_in 'Confirm Password', with: 'password123!'
    fill_in 'Street', with: '123 Elm St'
    fill_in 'City', with: 'Anytown'
    select 'California', from: 'State'
    fill_in 'Zip', with: '12345'
    select 'Pacific Time (US & Canada)', from: 'Time zone'

    click_button 'Sign Up'

    # Client-side validation: Check the browser validation message
    expect(check_validation_message('user_last_name', 'Please fill out this field.')).to be true
  end

  scenario 'User fails to register with all required fields missing' do
    click_button 'Sign Up'

    # Check for the presence of required field messages
    expect(check_validation_message('user_first_name', 'Please fill out this field.')).to be true
    expect(check_validation_message('user_last_name', 'Please fill out this field.')).to be true
    expect(check_validation_message('user_email', 'Please fill out this field.')).to be true
    expect(check_validation_message('user_password', 'Please fill out this field.')).to be true
    expect(check_validation_message('user_street', 'Please fill out this field.')).to be true
    expect(check_validation_message('user_city', 'Please fill out this field.')).to be true
    expect(check_validation_message('user_zip', 'Please fill out this field.')).to be true
  end
end
