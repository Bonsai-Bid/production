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
    end

    scenario 'form submits successfully with valid input for plant category' do
      visit new_item_path
    
      # Fill out valid data for plant category
      fill_in 'item_name', with: 'Beautiful Bonsai'
      fill_in 'item_description', with: 'Beautiful Bonsai Tree'
      select 'Plant', from: 'item_category_type'
      select 'Maple', from: 'item_plant_species'
      select 'Formal upright', from: 'item_plant_style'
      select 'Development', from: 'item_plant_stage'
      select 'Handmade', from: 'item_container_material'
      select 'Round', from: 'item_container_shape'
      select 'Green', from: 'item_container_color'
      select 'Japan', from: 'item_container_origin'
      select 'Medium', from: 'item_container_size'
      fill_in 'item_auction_attributes_starting_price', with: 100
      fill_in 'item_auction_attributes_bid_increment', with: 10
    
      # Submit form
      click_button 'Create Item'
    
      # Expect successful submission message
      expect(page).to have_content('Item was successfully created')
      expect(Item.last.auction).to be_present
    end

    scenario 'form submits successfully with valid input for container category' do
      visit new_item_path
    
      # Fill out valid data for container category
      fill_in 'item_name', with: 'Ceramic Pot'
      fill_in 'item_description', with: 'Beautiful Ceramic Pot'
      select 'Container', from: 'item_category_type'
      select 'Commercial', from: 'item_container_material'
      select 'Round', from: 'item_container_shape'
      select 'Blue', from: 'item_container_color'
      select 'China', from: 'item_container_origin'
      select 'Small', from: 'item_container_size'
      fill_in 'item_auction_attributes_starting_price', with: 100
      fill_in 'item_auction_attributes_bid_increment', with: 10
    
      # Submit form
      click_button 'Create Item'
    
      # Expect successful submission message
      expect(page).to have_content('Item was successfully created')
      expect(Item.last.auction).to be_present
    end

    scenario 'form submits successfully with valid input for essential type wire' do
      visit new_item_path
    
      # Fill out valid data for essential wire type
      fill_in 'item_name', with: 'Bonsai Wire'
      fill_in 'item_description', with: 'Some Aluminum Wire'

      select 'Essential', from: 'item_category_type'
      select 'Wire', from: 'item_essential_type'
      select 'Aluminum', from: 'item_wire_type'
      fill_in 'item_auction_attributes_starting_price', with: 100
      fill_in 'item_auction_attributes_bid_increment', with: 10
    
      # Submit form
      click_button 'Create Item'
    
      # Expect successful submission message
      expect(page).to have_content('Item was successfully created')
      expect(Item.last.auction).to be_present
    end

    scenario 'form submits successfully with valid input for essential type tools' do
      visit new_item_path
    
      # Fill out valid data for essential tools type
      fill_in 'item_name', with: 'Bonsai Shears'
      fill_in 'item_description', with: 'Some shears'
      select 'Essential', from: 'item_category_type'
      select 'Tool', from: 'item_essential_type'
      select 'Shears', from: 'item_tool_type'
      fill_in 'item_brand', with: 'BonsaiMaster'
      select 'New', from: 'item_condition'
      fill_in 'item_auction_attributes_starting_price', with: 100
      fill_in 'item_auction_attributes_bid_increment', with: 10
    
      # Submit form
      click_button 'Create Item'
    
      # Expect successful submission message
      expect(page).to have_content('Item was successfully created')
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

  context 'when auction fails to save' do
    it 'displays an error if the associated auction cannot be saved' do
      visit new_item_path

      fill_in 'item_name', with: 'Bonsai Shears'
      fill_in 'item_description', with: 'Some shears'
      select 'Essential', from: 'item_category_type'
      select 'Tool', from: 'item_essential_type'
      select 'Shears', from: 'item_tool_type'
      fill_in 'item_brand', with: 'BonsaiMaster'
      select 'New', from: 'item_condition'

      # Set invalid auction data to trigger a save failure
      fill_in 'Starting Price', with: -10  # Invalid starting price
      fill_in 'Bid Increment', with: 10
      choose 'List Now'

      click_button 'Create Item'

      starting_price_valid = page.evaluate_script("document.querySelector('#item_auction_attributes_starting_price').validity.valid")
      starting_price_validation_message = page.evaluate_script("document.querySelector('#item_auction_attributes_starting_price').validationMessage")
      
      expect(starting_price_valid).to be false
      expect(starting_price_validation_message).to include('Value must be greater than or equal to 0')
    end
  end
end
