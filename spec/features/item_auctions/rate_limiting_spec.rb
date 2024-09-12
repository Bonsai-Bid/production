# spec/features/rate_limiting_spec.rb

require 'rails_helper'

RSpec.describe 'Rate Limiting', type: :feature, js: true do
  let(:user) { create(:user) }

  before do
    # Simulate the rate limiter setup, e.g., using Rack::Attack or other rate-limiting middleware
    allow(Rack::Attack).to receive(:throttled_response).and_return(
      [429, { 'Content-Type' => 'text/plain' }, ['Rate limit exceeded']]
    )
  end

  context 'when testing rate limiting on login attempts' do
    it 'limits repeated login attempts to prevent brute-force attacks' do
      visit new_user_session_path

      # Attempt to log in with incorrect credentials repeatedly
      5.times do
        fill_in 'Email', with: user.email
        fill_in 'Password', with: 'wrongpassword'
        click_button 'Log in'
      end

      # Expect the rate limiting message to appear after several failed attempts
      fill_in 'Email', with: user.email
      fill_in 'Password', with: 'wrongpassword'
      click_button 'Log in'

      expect(page).to have_content('Rate limit exceeded')
      expect(page).to have_current_path(new_user_session_path)
    end
  end

  context 'when verifying rate limiting under heavy load or repeated requests' do
    it 'applies rate limits under high request loads' do
      visit items_path

      # Simulate heavy load by making multiple requests in a short period
      20.times do
        page.driver.get items_path
      end

      # Check for rate limit response
      response_status = page.evaluate_script('document.readyState')
      expect(response_status).not_to eq(200) # Expecting a rate limited response
      expect(response_status).to eq('Rate limit exceeded')
    end
  end

  context 'when confirming consistent application of rate limits across routes' do
    it 'applies rate limits consistently across different actions' do
      visit items_path

      # Test rate limits on multiple routes
      routes = [items_path, new_item_path, item_path(user.items.first)]
      routes.each do |route|
        5.times do
          visit route
        end

        # Check that rate limits are enforced consistently
        visit route
        expect(page).to have_content('Rate limit exceeded')
      end
    end
  end

  context 'when checking edge cases for rate limiting' do
    it 'handles rate limits correctly during concurrent sessions' do
      # Log in from multiple devices or sessions to test concurrent rate limiting
      visit new_user_session_path
      fill_in 'Email', with: user.email
      fill_in 'Password', with: user.password
      click_button 'Log in'

      # Simulate concurrent logins
      page.driver.browser.manage.delete_all_cookies # Clear session cookies to simulate another session
      visit new_user_session_path
      fill_in 'Email', with: user.email
      fill_in 'Password', with: user.password
      click_button 'Log in'

      # Check that rate limits apply across concurrent sessions
      5.times do
        visit items_path
      end

      # Expect rate limiting to trigger even with concurrent sessions
      visit items_path
      expect(page).to have_content('Rate limit exceeded')
    end

    it 'ensures rate limits do not affect valid actions by authenticated users' do
      login_as(user, scope: :user)

      # Perform valid actions within acceptable limits
      3.times do
        visit items_path
        expect(page).to have_content('Items')
      end

      # Verify that authenticated actions are not improperly rate limited
      expect(page).not_to have_content('Rate limit exceeded')
    end
  end
end
