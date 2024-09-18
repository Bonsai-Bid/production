# spec/features/item_and_auction_creation_spec.rb

require 'rails_helper'

RSpec.describe 'Item and Auction Creation', type: :feature, js: true do
  let(:user) { create(:user) }

  before do
    login_as(user, scope: :user)
  end

  context 'when creating a new item' do
    xit 'creates an item and automatically associates an auction' do
      visit new_item_path

      fill_in 'Name', with: 'Test Item'
      fill_in 'Description', with: 'A valid description for the item'
      select 'Plant', from: 'Category'

      # Fill out the required fields for a Plant category
      select 'Azalea', from: 'Species'
      select 'Broom', from: 'Style'
      select 'Development', from: 'Stage'
      select 'Commercial', from: 'Material'
      select 'Bag', from: 'Shape'
      select 'Black', from: 'Color'
      select 'Medium', from: 'Size'
      select 'China', from: 'Origin'

      # Auction attributes
      fill_in 'Starting Price', with: 100
      fill_in 'Bid Increment', with: 10
      choose 'List Now'

      click_button 'Create Item'

      expect(page).to have_content('Item and associated auction were successfully created.')
      expect(Item.last.auction).to be_present
    end
  end

  context 'when mandatory fields are missing' do
    it 'shows validation errors when mandatory fields are not filled' do
      visit new_item_path

      click_button 'Create Item'
      valid = page.evaluate_script("document.querySelector('#item_name').validity.valid")
      validation_message = page.evaluate_script("document.querySelector('#item_name').validationMessage")

      # Expectations
      expect(valid).to be false
      expect(validation_message).to include('Please fill out this field')

    end
  end

  context 'when entering invalid data' do
    xit 'shows validation errors for invalid enum values' do
      visit new_item_path

      fill_in 'Name', with: 'Invalid Item'
      fill_in 'Description', with: 'Invalid enum values'
      select 'Plant', from: 'Category'

      page.execute_script("document.querySelector('#item_species').value = 'invalid_value'")
      page.execute_script("document.querySelector('#item_material').value = 'invalid_value'")

      click_button 'Create Item'

      valid = page.evaluate_script("document.querySelector('#item_name').validity.valid")
      validation_message = page.evaluate_script("document.querySelector('#item_name').validationMessage")

      # Expectations
      expect(valid).to be false
      expect(validation_message).to include('Please fill out this field')
    end
  end

  context 'when auction fails to save' do
    xit 'displays an error if the associated auction cannot be saved' do
      visit new_item_path

      fill_in 'Name', with: 'Test Item'
      fill_in 'Description', with: 'A valid description'
      select 'Plant', from: 'Category'
      select 'Azalea', from: 'Species'
      select 'Broom', from: 'Style'
      select 'Pre bonsai', from: 'Stage'
      select 'Commercial', from: 'Material'
      select 'Bag', from: 'Shape'
      select 'Black', from: 'Color'
      select 'Medium', from: 'Size'
      select 'China', from: 'Origin'

      # Set invalid auction data to trigger a save failure
      fill_in 'Starting Price', with: -10  # Invalid starting price
      fill_in 'Bid Increment', with: 10
      choose 'List Now'

      click_button 'Create Item'

      expect(page).to have_content('Starting price must be greater than or equal to 0')
    end
  end
end
