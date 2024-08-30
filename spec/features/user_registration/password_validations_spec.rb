# spec/features/user_registration/password_validations_spec.rb
require 'rails_helper'

RSpec.feature 'User Registration - Password Validations', type: :feature, js: true do
  before do
    visit new_user_registration_path
  end

  scenario 'User fails to register with mismatched passwords' do
    fill_in 'First name', with: 'John'
    fill_in 'Last name', with: 'Doe'
    fill_in 'Email', with: 'test@example.com'
    fill_in 'Phone', with: '123-456-7890'
    fill_in 'Password', with: 'password123'
    fill_in 'Confirm Password', with: 'differentpassword'
    fill_in 'Street', with: '123 Elm St'
    fill_in 'City', with: 'Anytown'
    select 'California', from: 'State'
    fill_in 'Zip', with: '12345'
    select 'Pacific Time (US & Canada)', from: 'Time zone'

    click_button 'Sign Up'
    expect(page).to have_content("Password confirmation doesn't match Password")
  end

  scenario 'User fails to register with a short password' do
    fill_in 'First name', with: 'John'
    fill_in 'Last name', with: 'Doe'
    fill_in 'Email', with: 'test@example.com'
    fill_in 'Phone', with: '123-456-7890'
    fill_in 'Password', with: 'pass'
    fill_in 'Confirm Password', with: 'pass'
    fill_in 'Street', with: '123 Elm St'
    fill_in 'City', with: 'Anytown'
    select 'California', from: 'State'
    fill_in 'Zip', with: '12345'
    select 'Pacific Time (US & Canada)', from: 'Time zone'

    click_button 'Sign Up'
    expect(page).to have_content('Password is too short')
  end

  scenario 'User fails to register with password missing required complexity' do
    fill_in 'First name', with: 'John'
    fill_in 'Last name', with: 'Doe'
    fill_in 'Email', with: 'test@example.com'
    fill_in 'Phone', with: '123-456-7890'
    fill_in 'Password', with: 'password'  # No numbers or special characters
    fill_in 'Confirm Password', with: 'password'
    fill_in 'Street', with: '123 Elm St'
    fill_in 'City', with: 'Anytown'
    select 'California', from: 'State'
    fill_in 'Zip', with: '12345'
    select 'Pacific Time (US & Canada)', from: 'Time zone'
    
    click_button 'Sign Up'
    expect(page).to have_content('must include at least one special character (e.g. !@#$%^&*)')
  end

  scenario 'User registers with a maximum length password' do
    long_password = 'Aa2!' * 32  # Assuming max length is 128 characters
    fill_in 'First name', with: 'John'
    fill_in 'Last name', with: 'Doe'
    fill_in 'Email', with: 'test@example.com'
    fill_in 'Phone', with: '123-456-7890'
    fill_in 'Password', with: long_password
    fill_in 'Confirm Password', with: long_password
    fill_in 'Street', with: '123 Elm St'
    fill_in 'City', with: 'Anytown'
    select 'California', from: 'State'
    fill_in 'Zip', with: '12345'
    select 'Pacific Time (US & Canada)', from: 'Time zone'
    
    click_button 'Sign Up'
    expect(page).to have_content('Welcome! You have signed up successfully.')
  end
end
