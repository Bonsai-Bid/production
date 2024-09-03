# *****************************************
# FIX TESTS AFTER MEETING WITH DESIGN TEAM 
# *****************************************



# # spec/features/user_registration/accessibility_spec.rb
# require 'rails_helper'

# RSpec.feature 'User Registration Accessibility', type: :feature, js: true do
#   before do
#     # Register the headful mode driver specifically for these tests
#     Capybara.register_driver :selenium_chrome_headful do |app|
#       options = Selenium::WebDriver::Chrome::Options.new
#       options.add_argument('--disable-gpu')
#       options.add_argument('--window-size=1400,1400')

#       Capybara::Selenium::Driver.new(
#         app,
#         browser: :chrome,
#         options: options
#       )
#     end

#     # Set the JavaScript driver to headful mode just for these tests
#     Capybara.javascript_driver = :selenium_chrome_headful

#     visit new_user_registration_path
#   end

#   after do
#     # Reset the JavaScript driver back to default to avoid affecting other tests
#     Capybara.javascript_driver = :selenium_chrome
#   end

#   scenario 'Input fields have accessible labels and ARIA attributes' do
#     expect(page).to have_css('input#user_first_name[aria-required="true"]', visible: :all)
#     expect(page).to have_css('input#user_email[aria-required="true"]', visible: :all)
#     expect(page).to have_css('input#user_password[aria-required="true"]', visible: :all)

#     fill_in 'Email', with: 'invalid'
#     click_button 'Sign Up'

#     # Client-side validation: Verify the error message for invalid email input
#     expect(page).to have_content("Please include an '@' in the email address.")
#   end
# end
