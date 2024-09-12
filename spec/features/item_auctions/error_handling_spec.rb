# spec/features/error_message_security_spec.rb

require 'rails_helper'

RSpec.describe 'Error Message Security', type: :feature, js: true do
  let(:user) { create(:user) }

  before do
    login_as(user, scope: :user)
  end

  context 'when checking error messages for sensitive information' do
    it 'does not reveal stack traces or database errors in the UI' do
      # Simulate a scenario that triggers an error, such as accessing a non-existent route
      visit '/nonexistent_route'

      # Check that the error message is user-friendly and does not reveal sensitive information
      expect(page).to have_content("The page you were looking for doesn't exist.")
      expect(page).not_to have_content('Exception')
      expect(page).not_to have_content('traceback')
      expect(page).not_to have_content('ActiveRecord::RecordNotFound')
    end

    it 'displays standardized, user-friendly error messages' do
      visit new_item_path

      # Trigger an error by submitting an incomplete form
      click_button 'Create Item'

      # Check for a user-friendly validation error message without sensitive details
      expect(page).to have_content('Please review the problems below:')
      expect(page).to have_content("Name can't be blank")
      expect(page).not_to have_content('Exception')
      expect(page).not_to have_content('traceback')
    end
  end

  context 'when testing different error states for consistent handling' do
    it 'handles invalid form submissions consistently' do
      visit new_item_path

      # Trigger a validation error by leaving required fields blank
      click_button 'Create Item'

      # Verify that the error message is consistent and user-friendly
      expect(page).to have_content('Please review the problems below:')
      expect(page).to have_content("Name can't be blank")
      expect(page).to have_content("Description can't be blank")
      expect(page).not_to have_content('traceback')
    end

    it 'handles unexpected server errors with a standard error message' do
      # Simulate a server error by triggering an exception in the controller
      allow_any_instance_of(ItemsController).to receive(:create).and_raise(StandardError, 'Unexpected error')

      visit new_item_path
      fill_in 'Name', with: 'Trigger Error'
      fill_in 'Description', with: 'This will trigger a server error'
      click_button 'Create Item'

      # Check for a generic error message
      expect(page).to have_content('Something went wrong')
      expect(page).not_to have_content('StandardError')
      expect(page).not_to have_content('Unexpected error')
    end
  end

  context 'when checking error logging for sensitive data exposure' do
    it 'ensures sensitive data is not logged during errors' do
      # Set up logging to capture output for inspection
      log_output = StringIO.new
      allow(Rails.logger).to receive(:error).and_wrap_original do |m, *args|
        log_output.puts(*args)
        m.call(*args)
      end

      # Trigger an error to check logging behavior
      visit '/nonexistent_route'

      # Check the captured logs
      log_contents = log_output.string
      expect(log_contents).not_to include(user.email) # Ensure sensitive user data is not logged
      expect(log_contents).not_to include('traceback')
      expect(log_contents).not_to include('Exception')
    end

    it 'does not log sensitive parameters in case of form errors' do
      visit new_item_path

      # Submit a form with invalid data
      fill_in 'Name', with: ''
      click_button 'Create Item'

      # Check logs for sensitive information
      log_output = StringIO.new
      allow(Rails.logger).to receive(:info).and_wrap_original do |m, *args|
        log_output.puts(*args)
        m.call(*args)
      end

      log_contents = log_output.string
      expect(log_contents).not_to include('password')
      expect(log_contents).not_to include('credit_card')
      expect(log_contents).to include('Validation failed')
    end
  end
end
