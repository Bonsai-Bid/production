# spec/features/user_registration/security_validations_spec.rb
require 'rails_helper'

RSpec.feature 'User Registration - Security Validations', type: :feature, js: true do
  before do
    visit new_user_registration_path
  end

  scenario 'User attempts XSS attack in input fields' do
    xss_script = '<script>alert("XSS")</script>'
    fill_in 'First name', with: xss_script
    fill_in 'Last name', with: 'Doe'
    fill_in 'Email', with: 'test@example.com'
    fill_in 'Phone', with: '123-456-7890'
    fill_in 'Password', with: 'password123'
    fill_in 'Confirm Password', with: 'password123'
    fill_in 'Street', with: '123 Elm St'
    fill_in 'City', with: 'Anytown'
    select 'California', from: 'State'
    fill_in 'Zip', with: '12345'
    select 'Pacific Time (US & Canada)', from: 'Time zone'
    
    click_button 'Sign Up'
    expect(page).not_to have_content('XSS')  # No script should be executed
    expect(page).to have_content('contains invalid characters')  # Assuming validation for scripts
  end

  scenario 'User attempts SQL injection in input fields' do
    sql_injection = "' OR '1'='1"
    fill_in 'First name', with: sql_injection
    fill_in 'Last name', with: 'Doe'
    fill_in 'Email', with: 'test@example.com'
    fill_in 'Phone', with: '123-456-7890'
    fill_in 'Password', with: 'password123'
    fill_in 'Confirm Password', with: 'password123'
    fill_in 'Street', with: '123 Elm St'
    fill_in 'City', with: 'Anytown'
    select 'California', from: 'State'
    fill_in 'Zip', with: '12345'
    select 'Pacific Time (US & Canada)', from: 'Time zone'
    
    click_button 'Sign Up'
    expect(page).to have_content('contains invalid characters')  # Should catch invalid input
  end

  scenario 'User inputs large amounts of data to test field limits' do
    large_input = 'A' * 1000
    
    visit new_user_registration_path
  
    # Use JavaScript to bypass the maxlength constraint
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
  
end
