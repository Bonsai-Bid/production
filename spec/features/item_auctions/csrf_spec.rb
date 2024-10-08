# # spec/features/csrf_protection_spec.rb

# require 'rails_helper'

# RSpec.describe 'CSRF Protection', type: :feature, js: true do
#   let(:user) { create(:user) }
#   let(:item) { create(:item, seller: user) }

#   before do
#     login_as(user, scope: :user)
#   end

#   context 'when verifying CSRF tokens in forms' do
#     it 'includes a CSRF token in the form' do
      
#       visit new_item_path
#       expect(page).to have_selector('meta[name="csrf-token"]', visible: false)

#       csrf_meta_token = page.evaluate_script("document.querySelector('meta[name=\"csrf-token\"]').getAttribute('content')")
#       form_token = page.evaluate_script("document.querySelector('input[name=\"authenticity_token\"]').value")
    
#       expect(csrf_meta_token).not_to be_nil, 'CSRF meta token is missing'
#       expect(form_token).not_to be_nil, 'CSRF form token is missing'
#       expect(csrf_meta_token).to eq(form_token)
#     end
#   end

#   context 'when CSRF token is missing or incorrect' do
#     it 'fails when CSRF token is missing' do
#       visit new_item_path

#       # Submit the form with the CSRF token removed
#       page.execute_script("document.querySelector('input[name=\"authenticity_token\"]').remove()")
#       click_button 'Create Item'

#       # Check for error or protection response
#       expect(page).to have_content('Invalid authenticity token')
#     end

#     it 'fails when CSRF token is incorrect' do
#       visit new_item_path

#       # Tamper with the CSRF token value
#       page.execute_script("document.querySelector('input[name=\"authenticity_token\"]').value = 'invalid_token'")
#       click_button 'Create Item'

#       # Check for error or protection response
#       expect(page).to have_content('Invalid authenticity token')
#     end
#   end

#   context 'when testing CSRF token edge cases' do
#     it 'fails when CSRF token is expired' do
#       visit new_item_path

#       # Simulate an expired CSRF token by manipulating session state
#       old_token = page.evaluate_script("document.querySelector('input[name=\"authenticity_token\"]').value")
#       Rails.application.load_tasks
#       Rake::Task['devise:expire_tokens'].invoke # Assuming there's a rake task to expire tokens

#       # Submit form with the expired token
#       page.execute_script("document.querySelector('input[name=\"authenticity_token\"]').value = '#{old_token}'")
#       click_button 'Create Item'

#       # Check for error due to expired token
#       expect(page).to have_content('Invalid authenticity token')
#     end

#     it 'ensures CSRF protections under different session states' do
#       visit new_item_path

#       # Check CSRF protection under normal session state
#       click_button 'Create Item'
#       expect(page).to have_content('Please review the problems below:') # Assuming the form re-renders on failure

#       # Log out to test session state change
#       logout(:user)
#       visit new_item_path

#       # Submit the form again after logging out
#       click_button 'Create Item'

#       # Check for redirect to login due to CSRF protection after session state change
#       expect(page).to have_current_path(new_user_session_path)
#       expect(page).to have_content('You need to sign in or sign up before continuing.')
#     end
#     it 'includes security headers in the response' do
#       visit new_item_path
      
#       expect(page.response_headers['X-Frame-Options']).to eq('DENY')
#       expect(page.response_headers['X-Content-Type-Options']).to eq('nosniff')
#       expect(page.response_headers['X-XSS-Protection']).to eq('1; mode=block')
#       expect(page.response_headers['Content-Security-Policy']).to be_present
#     end
#   end
# end
