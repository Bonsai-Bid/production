# spec/features/https_enforcement_spec.rb

require 'rails_helper'

RSpec.describe 'HTTPS Enforcement', type: :feature, js: true do
  let(:user) { create(:user) }

  before do
    login_as(user, scope: :user)
  end

  context 'when verifying HTTPS enforcement' do
    it 'enforces HTTPS for all communications' do
      # Simulate visiting the site via HTTP and check for redirect to HTTPS
      Capybara.app_host = 'http://example.com'
      visit root_path

      # Check that the user is redirected to HTTPS
      expect(page.current_url).to start_with('https://')

      # Reset Capybara app host
      Capybara.app_host = nil
    end

    xit 'ensures no sensitive data is transmitted over insecure connections' do
      visit new_item_path

      # Simulate inspecting the network requests
      expect(page.evaluate_script('window.location.protocol')).to eq('https:')

      # Fill in sensitive information and check that it's submitted over HTTPS
      fill_in 'Name', with: 'Secure Item'
      fill_in 'Description', with: 'This is a secure description'
      select 'Essential', from: 'Category'
      select 'Decorations', from: 'Essential Type'
      click_button 'Create Item'

      # Verify that sensitive data is not logged or transmitted over HTTP
      expect(page.current_url).to start_with('https://')
      expect(page).to have_content('Item and associated auction were successfully created.')
    end
  end

  context 'when testing redirect behavior from HTTP to HTTPS' do
    it 'redirects from HTTP to HTTPS to ensure proper enforcement' do
      Capybara.app_host = 'http://example.com'
      visit root_path

      # Verify that the request was redirected to HTTPS
      expect(page.current_url).to start_with('https://')

      # Attempt to force HTTP and check that it redirects back to HTTPS
      visit root_path(secure: false)
      expect(page.current_url).to start_with('https://')

      # Reset Capybara app host
      Capybara.app_host = nil
    end
  end

  context 'when checking for mixed content issues' do
    xit 'ensures no mixed content issues where resources might load over HTTP' do
      visit root_path

      # Use JS to inspect the page for mixed content warnings
      mixed_content = page.evaluate_script(<<~JS)
        Array.from(document.querySelectorAll('img, script, link')).filter(el => 
          el.src && el.src.startsWith('http://')
        ).length
      JS

      # Expect no resources to load over HTTP
      expect(mixed_content).to eq(0)

      # Check that no mixed content errors are shown in the console
      log = page.driver.browser.manage.logs.get(:browser)
      expect(log).not_to include(/Mixed Content/i)
    end
  end
end
