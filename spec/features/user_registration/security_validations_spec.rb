# spec/features/user_registration/security_validations_spec.rb
require 'rails_helper'

RSpec.feature 'User Registration - Security Validations', type: :feature, js: true do
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

  scenario 'User attempts XSS attack in input fields' do
    xss_script = '<script>alert("XSS")</script>'
    fill_in 'First name', with: xss_script
    fill_in 'Last name', with: 'Doe'
    fill_in 'Email', with: 'test@example.com'
    fill_in 'Phone', with: '123-456-7890'
    fill_in 'Password', with: 'password123@'
    fill_in 'Confirm Password', with: 'password123@'
    fill_in 'Street', with: '123 Elm St'
    fill_in 'City', with: 'Anytown'
    select 'California', from: 'State'
    fill_in 'Zip', with: '12345'
    select 'Pacific Time (US & Canada)', from: 'Time zone'
    
    click_button 'Sign Up'
    
    # Check for the client-side prevention or error message
    expect(page).not_to have_content('XSS')  # No script should be executed
    expect(page).to have_content('contains invalid characters')  # Assuming validation for scripts
  end

# ************************************************************
# REVISIT THIS METHOD AND SEE IF YOU CAN 
# ************************************************************

  scenario 'User attempts SQL injection in input fields' do
    sql_injection = "' OR '1'='1"
    fill_in 'First name', with: sql_injection
    fill_in 'Last name', with: 'Doe'
    fill_in 'Email', with: 'test@example.com'
    fill_in 'Phone', with: '123-456-7890'
    fill_in 'Password', with: '!password123'
    fill_in 'Confirm Password', with: '!password123'
    fill_in 'Street', with: '123 Elm St'
    fill_in 'City', with: 'Anytown'
    select 'California', from: 'State'
    fill_in 'Zip', with: '12345'
    select 'Pacific Time (US & Canada)', from: 'Time zone'
    
    click_button 'Sign Up'
    
    # Check for the client-side prevention or error message
    expect(page).to have_content('contains invalid characters')  # Should catch invalid input
  end

  scenario 'User inputs large amounts of data to test field limits' do
    large_input = 'A' * 1000
    
    # Use JavaScript to bypass the maxlength constraint on fields
    page.execute_script("document.getElementById('user_first_name').value = '#{large_input}';")
    page.execute_script("document.getElementById('user_street').value = '#{large_input}';")
    page.execute_script("document.getElementById('user_city').value = '#{large_input}';")
  
    fill_in 'Last name', with: 'Doe'
    fill_in 'Email', with: 'test@example.com'
    fill_in 'Phone', with: '123-456-7890'
    fill_in 'Password', with: 'password123!'
    fill_in 'Confirm Password', with: 'password123!'
    select 'California', from: 'State'
    fill_in 'Zip', with: '12345'
    select 'Pacific Time (US & Canada)', from: 'Time zone'
    
    click_button 'Sign Up'
  
    # Expect the error message from server-side validation
    expect(page).to have_content('First name is too long')  # Example error for exceeding field limits
  end

# ************************************************************
# CHECK JAVASCRIPT DRIVER AND MAKE SURE IT IS SET UP FOR THIS
# ************************************************************
  
  # scenario 'Ensures CSRF token is present in registration form' do
  #   # Check that the CSRF meta tag is present in the HTML
  #   expect(page).to have_css("meta[name='csrf-token']", visible: :all)

  #   # Check for the CSRF token in the form itself
  #   expect(page.html).to include('authenticity_token')

  #   fill_in 'First name', with: 'John'
  #   fill_in 'Last name', with: 'Doe'
  #   fill_in 'Email', with: 'test@example.com'
  #   fill_in 'Phone', with: '123-456-7890'
  #   fill_in 'Password', with: 'password123!'
  #   fill_in 'Confirm Password', with: 'password123!'
  #   fill_in 'Street', with: '123 Elm St'
  #   fill_in 'City', with: 'Anytown'
  #   select 'California', from: 'State'
  #   fill_in 'Zip', with: '12345'
  #   select 'Pacific Time (US & Canada)', from: 'Time zone'

  #   # Submit the form
  #   click_button 'Sign Up'
    
  #   # Check that the CSRF token is validated server-side
  #   expect(page).to have_content('Welcome! You have signed up successfully.')
  # end
end
