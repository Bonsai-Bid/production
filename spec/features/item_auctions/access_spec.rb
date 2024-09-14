# spec/features/access_control_spec.rb

require 'rails_helper'

RSpec.describe 'Access Control', type: :feature, js: true do
  let(:user) { create(:user) }
  let(:other_user) { create(:user) }
  let(:item) { create(:item, seller: user) }
  let!(:auction) { create(:auction, item: item, seller: user) }

  context 'when user is not authenticated' do
    xit 'redirects to login when attempting to create an item' do
      visit new_item_path

      # Check for redirect to the login page
      expect(page).to have_current_path(new_user_session_path)
      expect(page).to have_content('You need to sign in or sign up before continuing.')
    end

    xit 'redirects to login when attempting to edit an item' do
      visit edit_item_path(item)

      # Check for redirect to the login page
      expect(page).to have_current_path(new_user_session_path)
      expect(page).to have_content('You need to sign in or sign up before continuing.')
    end

    xit 'redirects to login when attempting to delete an item' do
      visit item_path(item)

      # Attempt to delete via the UI
      accept_confirm do
        click_link 'Delete'
      end

      # Check for redirect to the login page
      expect(page).to have_current_path(new_user_session_path)
      expect(page).to have_content('You need to sign in or sign up before continuing.')
    end
  end

  context 'when user is authenticated' do
    before do
      login_as(user, scope: :user)
    end

    xit 'allows the owner to create, edit, and delete their items and auctions' do
      # Create a new item
      visit new_item_path
      fill_in 'Name', with: 'User Item'
      fill_in 'Description', with: 'Description for user item'
      select 'Essential', from: 'Category'
      select 'Decorations', from: 'Essential Type'
      click_button 'Create Item'

      expect(page).to have_content('Item and associated auction were successfully created.')

      # Edit the item
      visit edit_item_path(Item.last)
      fill_in 'Name', with: 'Updated User Item'
      click_button 'Update Item'

      expect(page).to have_content('Item was successfully updated.')
      expect(page).to have_content('Updated User Item')

      # Delete the item
      visit item_path(Item.last)
      accept_confirm do
        click_link 'Delete'
      end

      expect(page).to have_content('Item was successfully destroyed.')
    end

    xit 'prevents other users from accessing or modifying items and auctions they do not own' do
      login_as(other_user, scope: :user)

      # Attempt to edit another user's item
      visit edit_item_path(item)

      expect(page).to have_content('You are not authorized to access this page.')
      expect(page).to have_current_path(root_path)

      # Attempt to delete another user's item via direct URL manipulation
      page.driver.submit :delete, item_path(item), {}

      # Check that the item still exists
      expect(Item.exists?(item.id)).to be true
      expect(page).to have_content('You are not authorized to perform this action.')
    end
  end

  context 'when testing edge cases' do
    xit 'denies access to restricted actions via direct URL manipulation' do
      login_as(other_user, scope: :user)

      # Attempt to directly visit the delete action via URL
      visit item_path(item)
      page.driver.submit :delete, item_path(item), {}

      # Check for appropriate access denial
      expect(page).to have_content('You are not authorized to perform this action.')
      expect(Item.exists?(item.id)).to be true
    end

    xit 'tests access control after session expiration or logging out' do
      login_as(user, scope: :user)
      
      visit edit_item_path(item)

      # Simulate session expiration or logout
      logout(:user)
      visit edit_item_path(item)

      # Check for redirect to the login page after session expiration
      expect(page).to have_current_path(new_user_session_path)
      expect(page).to have_content('You need to sign in or sign up before continuing.')
    end
  end
end
