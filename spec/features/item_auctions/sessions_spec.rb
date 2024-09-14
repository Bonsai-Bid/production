# spec/features/session_security_spec.rb

require 'rails_helper'

RSpec.describe 'Session Security', type: :feature, js: true do
  let(:user) { create(:user) }

  before do
    login_as(user, scope: :user)
  end

  context 'when verifying session invalidation on logout' do
    xit 'properly invalidates the session upon logout' do
      visit root_path

      # Log out the user
      click_link 'Logout'

      # Attempt to access a restricted page after logout
      visit items_path

      # Expect to be redirected to the login page
      expect(page).to have_current_path(new_user_session_path)
      expect(page).to have_content('You need to sign in or sign up before continuing.')
    end
  end

  context 'when checking session cookies security' do
    xit 'ensures session cookies have HttpOnly, Secure, and SameSite attributes' do
      visit root_path

      # Check session cookies in the browser
      cookies = page.driver.browser.manage.all_cookies
      session_cookie = cookies.find { |cookie| cookie[:name].include?('_session') }

      # Expectations for session cookie security attributes
      expect(session_cookie[:httponly]).to be true
      expect(session_cookie[:secure]).to be true
      expect(session_cookie[:samesite]).to eq('Lax').or eq('Strict')
    end
  end

  context 'when testing session behavior on concurrent logins' do
    xit 'handles concurrent logins from different devices or browsers' do
      # Log in from the first browser
      visit new_user_session_path
      fill_in 'Email', with: user.email
      fill_in 'Password', with: user.password
      click_button 'Log in'

      # Simulate a second login from a different browser or device
      page.driver.browser.manage.delete_all_cookies # Clear cookies to simulate a new session
      visit new_user_session_path
      fill_in 'Email', with: user.email
      fill_in 'Password', with: user.password
      click_button 'Log in'

      # Expect the second login to succeed without invalidating the first session
      expect(page).to have_content('Signed in successfully.')
      expect(page).to have_current_path(root_path)

      # Verify that both sessions are active
      visit items_path
      expect(page).to have_content('Items') # Access without issues from both sessions
    end
  end

  context 'when checking for session hijacking prevention' do
    xit 'blocks session hijacking attempts by validating session tokens' do
      visit root_path

      # Capture the current session cookie
      session_cookie = page.driver.browser.manage.cookie_named('_session')

      # Simulate session hijacking by modifying the session cookie
      page.driver.browser.manage.add_cookie(name: '_session', value: 'hijacked_value')

      # Attempt to visit a restricted page with the tampered session
      visit items_path

      # Expect the session to be invalid and redirect to login due to hijacking attempt
      expect(page).to have_current_path(new_user_session_path)
      expect(page).to have_content('You need to sign in or sign up before continuing.')

      # Restore the valid session cookie
      page.driver.browser.manage.add_cookie(session_cookie)
      visit items_path

      # Check that the valid session still works
      expect(page).to have_content('Items')
    end
  end
end
