# spec/features/items/create_spec.rb

require 'rails_helper'

RSpec.describe 'Create Item', type: :feature, js: true do
  let(:user) { create(:user) }

  before do
    sign_in user
  end

  context 'with valid inputs' do
    xit 'creates a new item and redirects to dashboard' do
      visit new_item_path
      fill_in 'Name', with: 'Test Item'
      fill_in 'Description', with: 'A description of the test item'
      select 'Plant', from: 'Category' # Adjust based on the available options
      expect(page).to have_selector('#plant_fields', visible: true)
      within('#plant_fields') do
        select 'Maple', from: 'Species'
        select 'Formal upright', from: 'Style' # Assuming 'Formal Upright' is a valid option
        select 'Refinement', from: 'Stage'         
      end

      # Ensure container fields are visible and interact with them
      expect(page).to have_selector('#container_fields', visible: true)

      within('#container_fields') do
        select 'Commercial', from: 'Material'      # Assuming 'Clay' is a valid option
        select 'Round', from: 'Shape'        # Assuming 'Round' is a valid option
        select 'Green', from: 'Color'          # Assuming 'Red' is a valid option
        select 'Japan', from: 'Origin'       # Assuming 'Japan' is a valid option
        select 'Medium', from: 'Size'        # Assuming 'Medium' is a valid option
      end


        fill_in 'Starting Price', with: '50'          # Assuming this field is labeled correctly
        fill_in 'Minimum Bid Increment', with: '5'    # Assuming this field is labeled correctly


      expect(page).to have_selector('#enable_buy_it_now', visible: true)

      # Use a direct interaction with the checkbox using its ID
      find('#enable_buy_it_now').click

      # Ensure that the Buy It Now Price field becomes visible after checking
      expect(page).to have_selector('#buy_it_now_price_field', visible: true)
      fill_in 'Buy It Now Price', with: '100'

      click_button 'Create Item'
      expect(page).to have_current_path(dashboard_user_path(user))
      expect(page).to have_content('Item and associated auction were successfully created.')
    end
  end

  context 'with missing required fields' do
    it 'shows HTML5 validation messages' do
      visit new_item_path
      fill_in 'Name', with: '' # Clear name field to trigger validation

      # Attempt to submit the form
      click_button 'Create Item'

      # Check if the name field is marked as invalid
      valid = page.evaluate_script("document.querySelector('#item_name').validity.valid")
      validation_message = page.evaluate_script("document.querySelector('#item_name').validationMessage")

      # Expectations
      expect(valid).to be false
      expect(validation_message).to include('Please fill out this field')
    end
  end
end
