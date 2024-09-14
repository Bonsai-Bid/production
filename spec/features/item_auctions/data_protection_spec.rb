# spec/features/data_exposure_spec.rb

require 'rails_helper'

RSpec.describe 'Data Exposure', type: :feature, js: true do
  let(:user) { create(:user, email: 'user@example.com') }
  let(:other_user) { create(:user, email: 'other@example.com') }

  before do
    login_as(user, scope: :user)
  end

  context 'when checking for sensitive data exposure in the UI' do
    xit 'does not display sensitive user information in the UI' do
      visit user_path(user)

      # Check that the user email is not displayed in the profile
      expect(page).not_to have_content(user.email)
      expect(page).to have_content('Profile') # Confirm the profile page loaded correctly
    end
  end

  context 'when verifying sensitive data exposure in API responses' do
    xit 'does not expose sensitive data in JSON responses' do
      visit api_user_path(user, format: :json)

      # Parse the JSON response and check that sensitive data is not present
      response_body = JSON.parse(page.body)
      expect(response_body).not_to include('email' => user.email)
      expect(response_body).not_to have_key('password')
      expect(response_body).to include('id' => user.id)
    end

    xit 'ensures error messages do not expose stack traces or sensitive information' do
      # Simulate a scenario that would cause an error, such as a routing error
      visit '/nonexistent_route'

      # Check that no stack trace or sensitive information is exposed
      expect(page).to have_content('The page you were looking for doesn\'t exist.')
      expect(page).not_to have_content('Exception')
      expect(page).not_to have_content('traceback')
    end
  end

  context 'when testing for accidental data leaks through unexpected routes' do
    xit 'does not expose sensitive information via unexpected routes' do
      # Attempt to access a restricted or unexpected route
      visit "/users/#{user.id}/edit" # Example of a route that may accidentally expose data

      # Check that sensitive information is not displayed
      expect(page).to have_content('You are not authorized to access this page.')
      expect(page).not_to have_content(user.email)
    end
  end

  context 'when checking for excessive data exposure in developer tools' do
    it 'ensures no excessive data exposure in network responses' do
      visit items_path

      # Check network responses for any excessive data exposure
      response_body = page.evaluate_script('document.body.innerHTML')
      expect(response_body).not_to include(user.email)
      expect(response_body).not_to include(other_user.email)
    end

    xit 'ensures JSON responses do not contain unnecessary data' do
      # Visit a path that returns JSON and check the data exposure
      visit api_items_path(format: :json)

      response_body = JSON.parse(page.body)
      response_body.each do |item|
        expect(item).not_to have_key('user_email')
        expect(item).not_to have_key('sensitive_data')
      end
    end
  end
end
