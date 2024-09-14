# spec/features/file_validation_spec.rb

require 'rails_helper'

RSpec.describe 'File Validation', type: :feature, js: true do
  let(:user) { create(:user) }

  before do
    login_as(user, scope: :user)
  end

  context 'when uploading allowed file types' do
    xit 'allows uploading JPEG and PNG files' do
      visit new_item_path

      # Fill in required fields
      fill_in 'Name', with: 'Test Item with Image'
      fill_in 'Description', with: 'Item with a valid image upload'
      select 'Essential', from: 'Category'
      select 'Decorations', from: 'Essential Type'

      # Upload a valid JPEG file
      attach_file('Images', Rails.root.join('spec/fixtures/files/valid_image.jpg'))
      click_button 'Create Item'

      # Expect the upload to succeed
      expect(page).to have_content('Item and associated auction were successfully created.')
      expect(Item.last.images.attached?).to be true

      # Upload a valid PNG file
      visit new_item_path
      fill_in 'Name', with: 'Test Item with PNG'
      fill_in 'Description', with: 'Item with a valid PNG upload'
      select 'Essential', from: 'Category'
      select 'Decorations', from: 'Essential Type'

      attach_file('Images', Rails.root.join('spec/fixtures/files/valid_image.png'))
      click_button 'Create Item'

      expect(page).to have_content('Item and associated auction were successfully created.')
      expect(Item.last.images.attached?).to be true
    end
  end

  context 'when testing against malicious file uploads' do
    xit 'rejects scripts disguised as images' do
      visit new_item_path

      # Fill in required fields
      fill_in 'Name', with: 'Malicious File Test'
      fill_in 'Description', with: 'Attempting to upload a script disguised as an image'
      select 'Essential', from: 'Category'
      select 'Decorations', from: 'Essential Type'

      # Attempt to upload a script disguised as an image
      attach_file('Images', Rails.root.join('spec/fixtures/files/malicious_image.jpg'))
      click_button 'Create Item'

      # Expect validation to reject the malicious file
      expect(page).to have_content('is not a valid file type')
      expect(Item.last.images.attached?).to be false
    end
  end

  context 'when testing edge cases with unsupported formats and large files' do
    xit 'rejects unsupported file formats' do
      visit new_item_path

      # Fill in required fields
      fill_in 'Name', with: 'Unsupported File Format Test'
      fill_in 'Description', with: 'Testing unsupported file format upload'
      select 'Essential', from: 'Category'
      select 'Decorations', from: 'Essential Type'

      # Attempt to upload an unsupported file format (e.g., .exe)
      attach_file('Images', Rails.root.join('spec/fixtures/files/unsupported_file.exe'))
      click_button 'Create Item'

      # Check for validation error
      expect(page).to have_content('is not a valid file type')
      expect(Item.last.images.attached?).to be false
    end

    xit 'rejects large file uploads beyond the size limit' do
      visit new_item_path

      # Fill in required fields
      fill_in 'Name', with: 'Large File Test'
      fill_in 'Description', with: 'Testing large file upload'
      select 'Essential', from: 'Category'
      select 'Decorations', from: 'Essential Type'

      # Attempt to upload a large file
      attach_file('Images', Rails.root.join('spec/fixtures/files/large_image.jpg'))
      click_button 'Create Item'

      # Check for validation error related to file size
      expect(page).to have_content('is too large')
      expect(Item.last.images.attached?).to be false
    end
  end

  context 'when verifying that files do not execute on server or client side' do
    xit 'ensures uploaded files are treated as data, not executable scripts' do
      visit new_item_path

      # Fill in required fields
      fill_in 'Name', with: 'Safe File Handling Test'
      fill_in 'Description', with: 'Ensuring uploaded files are safe'
      select 'Essential', from: 'Category'
      select 'Decorations', from: 'Essential Type'

      # Upload a valid image file
      attach_file('Images', Rails.root.join('spec/fixtures/files/valid_image.jpg'))
      click_button 'Create Item'

      # Expect the upload to succeed without executing any code
      expect(page).to have_content('Item and associated auction were successfully created.')
      expect(Item.last.images.attached?).to be true

      # Check that the uploaded file's content is not executed as a script
      visit item_path(Item.last)
      expect(page).not_to have_content('alert("XSS")') # Ensure no script execution
    end
  end
end
