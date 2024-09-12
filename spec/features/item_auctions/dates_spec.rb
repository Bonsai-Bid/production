# spec/features/auction_date_validations_spec.rb

require 'rails_helper'

RSpec.describe 'Auction Date Validations', type: :feature, js: true do
  let(:user) { create(:user) }
  let(:item) { create(:item, seller: user) }

  before do
    login_as(user, scope: :user)
  end

  context 'when setting auction start and end dates' do
    it 'does not allow the auction to be backdated' do
      visit new_item_path

      # Fill in required item fields
      fill_in 'Name', with: 'Test Item'
      fill_in 'Description', with: 'A valid description for the item'
      select 'Essential', from: 'Category'
      select 'Decorations', from: 'Essential Type'

      # Attempt to set the auction start date in the past
      fill_in 'Starting Price', with: 100
      fill_in 'Bid Increment', with: 10
      choose 'List Later'
      fill_in 'Start Date', with: (Date.today - 1).strftime('%Y-%m-%d')
      fill_in 'Start Time', with: '10:00'

      click_button 'Create Item'

      # Check for validation message
      expect(page).to have_content('Start date cannot be in the past')
    end

    it 'does not allow the end date to be set before the start date' do
      visit new_item_path

      # Fill in required item fields
      fill_in 'Name', with: 'Another Test Item'
      fill_in 'Description', with: 'Another valid description'
      select 'Essential', from: 'Category'
      select 'Decorations', from: 'Essential Type'

      # Set the start date and attempt to set the end date before the start date
      fill_in 'Starting Price', with: 200
      fill_in 'Bid Increment', with: 20
      choose 'List Later'
      fill_in 'Start Date', with: Date.today.strftime('%Y-%m-%d')
      fill_in 'Start Time', with: '10:00'
      fill_in 'End Time', with: '09:00' # End time before start time

      click_button 'Create Item'

      # Check for validation message
      expect(page).to have_content('End date must be after the start date')
    end
  end

  context 'when testing boundary date conditions' do
    it 'allows the start date to be exactly the current date and time' do
      visit new_item_path

      # Fill in required item fields
      fill_in 'Name', with: 'Boundary Date Test Item'
      fill_in 'Description', with: 'Description for boundary date test'
      select 'Essential', from: 'Category'
      select 'Decorations', from: 'Essential Type'

      # Set the start date to the current date and time
      fill_in 'Starting Price', with: 150
      fill_in 'Bid Increment', with: 15
      choose 'List Later'
      fill_in 'Start Date', with: Date.today.strftime('%Y-%m-%d')
      fill_in 'Start Time', with: Time.current.strftime('%H:%M')

      click_button 'Create Item'

      # Check that the auction was created successfully
      expect(page).to have_content('Item and associated auction were successfully created.')
    end

    it 'does not allow setting the start date in the past by a minimal amount (e.g., seconds)' do
      visit new_item_path

      # Fill in required item fields
      fill_in 'Name', with: 'Minimal Past Date Test Item'
      fill_in 'Description', with: 'Description for minimal past date test'
      select 'Essential', from: 'Category'
      select 'Decorations', from: 'Essential Type'

      # Attempt to set the start date slightly in the past
      fill_in 'Starting Price', with: 180
      fill_in 'Bid Increment', with: 18
      choose 'List Later'
      fill_in 'Start Date', with: (Time.current - 1.second).strftime('%Y-%m-%d')
      fill_in 'Start Time', with: (Time.current - 1.second).strftime('%H:%M')

      click_button 'Create Item'

      # Check for validation message
      expect(page).to have_content('Start date cannot be in the past')
    end
  end
end
