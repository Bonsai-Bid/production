# spec/features/user_registration/address_validations_spec.rb
require 'rails_helper'

RSpec.feature 'User Registration - Address Validations', type: :feature, js: true do
  before do
    visit new_user_registration_path
  end

  scenario 'User fails to register with missing address fields' do
    fill_in 'First name', with: 'John'
    fill_in 'Last name', with: 'Doe'
    fill_in 'Email', with: 'test@example.com'
    fill_in 'Phone', with: '123-456-7890'
    fill_in 'Password', with: 'password123!'
    fill_in 'Confirm Password', with: 'password123!'
    select 'California', from: 'State'
    select 'Pacific Time (US & Canada)', from: 'Time zone'

    click_button 'Sign Up'
    expect(page).to have_content("Street can't be blank")
    expect(page).to have_content("City can't be blank")
    expect(page).to have_content("Zip can't be blank")
  end
end
