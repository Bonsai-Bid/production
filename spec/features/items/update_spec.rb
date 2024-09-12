# spec/features/items/update_spec.rb

require 'rails_helper'

RSpec.describe 'Update Item', type: :feature, js: true do
  let(:user) { create(:user) }
  let!(:item) { create(:item, seller: user) }

  before do
    sign_in user
  end

  context 'with invalid inputs' do
    it 're-renders the edit form with errors' do
      visit edit_item_path(item)
      fill_in 'Name', with: ''
      click_button 'Update Item'
      valid = page.evaluate_script("document.querySelector('#item_name').validity.valid")
      validation_message = page.evaluate_script("document.querySelector('#item_name').validationMessage")

      # Expectations
      expect(valid).to be false
      expect(validation_message).to include('Please fill out this field')    
    end
  end
end
