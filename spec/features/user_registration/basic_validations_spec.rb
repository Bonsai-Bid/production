# spec/features/user_registration/basic_validations_spec.rb
require 'rails_helper'

RSpec.feature 'User Registration - Basic Validations', type: :feature, js: true do
  before do
    visit new_user_registration_path
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
    expect(page).to have_content("First name can't be blank")
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
    expect(page).to have_content("Last name can't be blank")
  end

  scenario 'User fails to register with all required fields missing' do
    click_button 'Sign Up'

    expect(page).to have_content("First name can't be blank")
    expect(page).to have_content("Last name can't be blank")
    expect(page).to have_content("Email can't be blank")
    expect(page).to have_content("Password can't be blank")
    expect(page).to have_content("Street can't be blank")
    expect(page).to have_content("City can't be blank")
    expect(page).to have_content("Zip can't be blank")
  end
end
