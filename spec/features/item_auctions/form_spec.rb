# spec/features/form_validation_spec.rb

require 'rails_helper'

RSpec.describe 'Form Validation', type: :feature, js: true do
  let(:user) { create(:user) }

  before do
    login_as(user, scope: :user)
  end

  context 'when submitting forms with missing or incorrect data' do
    it 'shows appropriate validation messages for missing required fields' do
      visit new_item_path

      # Attempt to submit the form without filling any fields
      click_button 'Create Item'

      # Check validation messages for required fields
      name_valid = page.evaluate_script("document.querySelector('#item_name').validity.valid")
      name_validation_message = page.evaluate_script("document.querySelector('#item_name').validationMessage")

      description_valid = page.evaluate_script("document.querySelector('#item_description').validity.valid")
      description_validation_message = page.evaluate_script("document.querySelector('#item_description').validationMessage")

      # Expectations
      expect(name_valid).to be false
      expect(name_validation_message).to include('Please fill out this field')

      expect(description_valid).to be false
      expect(description_validation_message).to include('Please fill out this field')
    end

    it 'persists entered data when validation fails' do
      visit new_item_path

      # Fill some fields and leave others blank
      fill_in 'Name', with: 'Partial Item'
      # Leave description blank

      click_button 'Create Item'

      # Check that the filled data persists
      expect(page.find_field('Name').value).to eq('Partial Item')
      expect(page.find_field('Description').value).to be_empty
    end
  end

  context 'when testing edge cases with special characters and long strings' do
    it 'handles special characters correctly' do
      visit new_item_path

      # Input special characters
      fill_in 'Name', with: '!@#$%^&*()_+|}{:"?><,./;\'[]\\=-`~'
      fill_in 'Description', with: 'Testing special characters: !@#$%^&*()'

      click_button 'Create Item'

      # Check that no client-side validation errors appear for special characters
      name_valid = page.evaluate_script("document.querySelector('#item_name').validity.valid")
      description_valid = page.evaluate_script("document.querySelector('#item_description').validity.valid")

      expect(name_valid).to be true
      expect(description_valid).to be true
    end

    it 'handles long string inputs robustly' do
      visit new_item_path

      # Input excessively long strings
      long_string = 'a' * 5000
      fill_in 'Name', with: long_string
      fill_in 'Description', with: long_string

      click_button 'Create Item'

      # Check that no client-side validation errors appear for long strings
      name_valid = page.evaluate_script("document.querySelector('#item_name').validity.valid")
      description_valid = page.evaluate_script("document.querySelector('#item_description').validity.valid")

      expect(name_valid).to be true
      expect(description_valid).to be true
    end
  end

  context 'when testing edge-case values like empty strings and unexpected data types' do
    it 'shows validation messages for empty strings when fields are required' do
      visit new_item_path

      # Input empty strings for required fields
      fill_in 'Name', with: ''
      fill_in 'Description', with: ''

      click_button 'Create Item'

      # Check validation messages
      name_valid = page.evaluate_script("document.querySelector('#item_name').validity.valid")
      name_validation_message = page.evaluate_script("document.querySelector('#item_name').validationMessage")

      expect(name_valid).to be false
      expect(name_validation_message).to include('Please fill out this field')
    end

    it 'handles unexpected data types (e.g., numbers in text fields)' do
      visit new_item_path

      # Input numbers in fields that are expected to be text
      fill_in 'Name', with: '1234567890'
      fill_in 'Description', with: '0987654321'

      click_button 'Create Item'

      # Check that fields accept numeric inputs as valid text
      name_valid = page.evaluate_script("document.querySelector('#item_name').validity.valid")
      description_valid = page.evaluate_script("document.querySelector('#item_description').validity.valid")

      expect(name_valid).to be true
      expect(description_valid).to be true
    end
  end
end
