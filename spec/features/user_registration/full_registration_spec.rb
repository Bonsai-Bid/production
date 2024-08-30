# spec/features/user_registration/full_registration_spec.rb
require 'rails_helper'

RSpec.feature 'User Registration - Full Form Submission', type: :feature, js: true do
  before do
    visit new_user_registration_path
  end

  scenario 'User registers successfully with valid inputs' do
    fill_in 'First name', with: 'John'
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
    expect(page).to have_content('Welcome! You have signed up successfully.')
  end
end
