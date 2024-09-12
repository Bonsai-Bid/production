# spec/features/auction_edit_restrictions_spec.rb

require 'rails_helper'

RSpec.describe 'Auction Edit Restrictions', type: :feature, js: true do
  let(:user) { create(:user) }
  let(:other_user) { create(:user) }
  let(:item) { create(:item, seller: user) }
  let!(:active_auction) { create(:auction, item: item, seller: user, status: :active) }
  let!(:listed_auction) { create(:auction, item: item, seller: user, status: :listed) }

  before do
    login_as(user, scope: :user)
  end

  context 'when auction is active' do
    it 'does not allow editing auction details via the UI' do
      visit edit_auction_path(active_auction)

      # The form should not be editable, or the fields should be disabled
      expect(page).to have_content('Auction is active and cannot be edited')
      expect(page).not_to have_button('Update Auction')
      expect(page).not_to have_field('Starting Price')
      expect(page).not_to have_field('Bid Increment')
    end

    it 'does not allow editing auction details via direct URL manipulation' do
      # Attempt to update an active auction via a PATCH request
      page.driver.submit :patch, auction_path(active_auction), {
        auction: { starting_price: 150, bid_increment: 15 }
      }

      # Confirm that the changes did not occur
      expect(active_auction.reload.starting_price).not_to eq(150)
      expect(active_auction.reload.bid_increment).not_to eq(15)

      # Check for appropriate flash message or error response
      expect(page).to have_content('Auction is active and cannot be edited')
    end

    it 'does not allow API updates to an active auction' do
      # Simulate an API request to update the auction
      headers = { 'ACCEPT' => 'application/json' }
      patch auction_path(active_auction), params: {
        auction: { starting_price: 150, bid_increment: 15 }
      }, headers: headers

      # Ensure that the auction remains unchanged
      expect(active_auction.reload.starting_price).not_to eq(150)
      expect(response).to have_http_status(:forbidden)
      expect(response.body).to include('Auction is active and cannot be edited')
    end
  end

  context 'when auction is listed' do
    it 'allows editing auction details via the UI' do
      visit edit_auction_path(listed_auction)

      fill_in 'Starting Price', with: 150
      fill_in 'Bid Increment', with: 15
      click_button 'Update Auction'

      expect(page).to have_content('Auction was successfully updated.')
      expect(listed_auction.reload.starting_price).to eq(150)
      expect(listed_auction.reload.bid_increment).to eq(15)
    end
  end

  context 'when accessing auction as a different user' do
    before do
      login_as(other_user, scope: :user)
    end

    it 'does not allow another user to access the edit page of an active auction' do
      visit edit_auction_path(active_auction)

      # Should redirect or display an authorization error
      expect(page).to have_content('You are not authorized to access this page.')
      expect(page.current_path).not_to eq(edit_auction_path(active_auction))
    end

    it 'does not allow another user to update an auction via direct URL manipulation' do
      # Attempt to update the auction as another user
      page.driver.submit :patch, auction_path(active_auction), {
        auction: { starting_price: 200 }
      }

      # Check that the unauthorized attempt was rejected
      expect(page).to have_content('You are not authorized to perform this action.')
      expect(active_auction.reload.starting_price).not_to eq(200)
    end
  end

  context 'when auction status transitions from listed to active' do
    it 'prevents further editing once the auction becomes active' do
      visit edit_auction_path(listed_auction)

      fill_in 'Starting Price', with: 160
      click_button 'Update Auction'

      # Simulate auction becoming active
      listed_auction.update(status: :active)

      visit edit_auction_path(listed_auction)

      # Should now restrict edits due to active status
      expect(page).to have_content('Auction is active and cannot be edited')
      expect(page).not_to have_button('Update Auction')
    end
  end

  context 'when manipulating auction status via console or API' do
    it 'ensures that status cannot be changed to active without validation' do
      # Directly update the status bypassing the UI controls
      active_auction.update_column(:status, 'ended')

      # Verify that the auction's state is still checked elsewhere and cannot revert to active inappropriately
      expect(active_auction.reload.status).to eq('ended')
      expect { active_auction.update(status: 'active') }.to raise_error(ActiveRecord::RecordInvalid)
    end
  end
end
