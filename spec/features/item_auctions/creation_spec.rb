# spec/features/item_and_auction_creation_spec.rb

require 'rails_helper'

RSpec.describe 'Item and Auction Creation', type: :feature, js: true do
  let(:user) { create(:user) }

  before do
    login_as(user, scope: :user)
  end

  context 'when creating a new item' do
    scenario 'form should not submit when no fields are filled' do
      visit new_item_path
  
      # Submit form without filling any fields
      click_button 'Create Item'
  
      # Check validation for missing name
      name_valid = page.evaluate_script("document.querySelector('#item_name').validity.valid")
      name_validation_message = page.evaluate_script("document.querySelector('#item_name').validationMessage")
      expect(name_valid).to be false
      expect(name_validation_message).to include('Please fill out this field')
  
      # Check validation for missing category
      category_type_valid = page.evaluate_script("document.querySelector('#item_category_type').validity.valid")
      category_type_validation_message = page.evaluate_script("document.querySelector('#item_category_type').validationMessage")
      expect(category_type_valid).to be false
      expect(category_type_validation_message).to include('Please select a category')
    end

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

    scenario 'form submits successfully with valid input for plant category' do
      visit new_item_path
    
      # Fill out valid data for plant category
      fill_in 'item_name', with: 'Beautiful Bonsai'
      select 'Plant', from: 'item_category_type'
      select 'Maple', from: 'item_species'
      select 'Formal Upright', from: 'item_style'
      select 'Development', from: 'item_stage'
      select 'Handmade', from: 'item_material'
      select 'Round', from: 'item_shape'
      select 'Green', from: 'item_color'
      select 'Japan', from: 'item_origin'
      select 'Medium', from: 'item_size'
    
      # Submit form
      click_button 'Create Item'
    
      # Expect successful submission message
      expect(page).to have_content('Item was successfully created')
    end

    scenario 'form submits successfully with valid input for container category' do
      visit new_item_path
    
      # Fill out valid data for container category
      fill_in 'item_name', with: 'Ceramic Pot'
      select 'Container', from: 'item_category_type'
      select 'Ceramic', from: 'item_material'
      select 'Round', from: 'item_shape'
      select 'Blue', from: 'item_color'
      select 'China', from: 'item_origin'
      select 'Small', from: 'item_size'
    
      # Submit form
      click_button 'Create Item'
    
      # Expect successful submission message
      expect(page).to have_content('Item was successfully created')
    end

    scenario 'form submits successfully with valid input for essential type wire' do
      visit new_item_path
    
      # Fill out valid data for essential wire type
      fill_in 'item_name', with: 'Bonsai Wire'
      select 'Essential', from: 'item_category_type'
      select 'Wire', from: 'item_essential_type'
      select 'Aluminum', from: 'item_wire'
    
      # Submit form
      click_button 'Create Item'
    
      # Expect successful submission message
      expect(page).to have_content('Item was successfully created')
    end

    scenario 'form submits successfully with valid input for essential type tools' do
      visit new_item_path
    
      # Fill out valid data for essential tools type
      fill_in 'item_name', with: 'Bonsai Shears'
      select 'Essential', from: 'item_category_type'
      select 'Tools', from: 'item_essential_type'
      select 'Shears', from: 'item_tool'
      fill_in 'item_brand', with: 'BonsaiMaster'
      select 'New', from: 'item_condition'
    
      # Submit form
      click_button 'Create Item'
    
      # Expect successful submission message
      expect(page).to have_content('Item was successfully created')
    end
    
    
  end

  scenario 'form submits successfully with valid input for essential type tools' do
    visit new_item_path
  
    # Fill out valid data for essential tools type
    fill_in 'item_name', with: 'Bonsai Shears'
    select 'Essential', from: 'item_category_type'
    select 'Tools', from: 'item_essential_type'
    select 'Shears', from: 'item_tool'
    fill_in 'item_brand', with: 'BonsaiMaster'
    select 'New', from: 'item_condition'
  
    # Submit form
    click_button 'Create Item'
  
    # Expect successful submission message
    expect(page).to have_content('Item was successfully created')
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
