# spec/features/injection_and_xss_prevention_spec.rb

require 'rails_helper'

RSpec.describe 'Injection and XSS Prevention', type: :feature, js: true do
  let(:user) { create(:user) }

  before do
    login_as(user, scope: :user)
  end

  context 'when testing for SQL Injection prevention' do
    it 'does not allow SQL commands to be executed through input fields' do
      visit new_item_path

      # Attempt to inject SQL commands into item name and description fields
      fill_in 'Name', with: "'; DROP TABLE users;--"
      fill_in 'Description', with: "1; DROP TABLE items;--"
      select 'Essential', from: 'Category'
      select 'Decorations', from: 'Essential Type'

      click_button 'Create Item'

      # Expect that SQL injection attempts are safely handled and do not cause harm
      expect(page).not_to have_content('Internal Server Error')
      expect(page).to have_content('Item and associated auction were successfully created.')
      expect(Item.last.name).to eq("'; DROP TABLE users;--")
      expect(Item.last.description).to eq("1; DROP TABLE items;--")
    end
  end

  context 'when testing for XSS prevention' do
    it 'sanitizes input to prevent scripts from executing' do
      visit new_item_path

      # Attempt to input XSS attack vectors
      fill_in 'Name', with: '<script>alert("XSS")</script>'
      fill_in 'Description', with: '<img src="x" onerror="alert(\'XSS\')">'
      select 'Essential', from: 'Category'
      select 'Decorations', from: 'Essential Type'

      click_button 'Create Item'

      # Check that scripts are not executed and are sanitized in the output
      expect(page).not_to have_content('alert("XSS")')
      expect(page).to have_content('<script>alert("XSS")</script>')
      expect(page).to have_content('<img src="x" onerror="alert(\'XSS\')">')
    end

    it 'handles various XSS vectors, such as event handlers and script tags' do
      visit new_item_path

      # Attempt various XSS payloads
      xss_payloads = [
        '<script>alert("XSS1")</script>',
        '<img src="x" onerror="alert(\'XSS2\')">',
        '<body onload="alert(\'XSS3\')">',
        '<input type="text" value="XSS4" onfocus="alert(\'XSS4\')">',
        '<a href="javascript:alert(\'XSS5\')">Click me</a>'
      ]

      xss_payloads.each_with_index do |payload, index|
        fill_in 'Name', with: "XSS Test #{index}"
        fill_in 'Description', with: payload
        select 'Essential', from: 'Category'
        select 'Decorations', from: 'Essential Type'
        click_button 'Create Item'

        # Check that scripts are not executed and payloads are sanitized in the output
        expect(page).not_to have_content("alert(\"XSS#{index + 1}\")")
        expect(page).to have_content(payload)

        visit new_item_path # Reset form for next payload
      end
    end

    it 'ensures JavaScript inputs are escaped to prevent XSS attacks' do
      visit new_item_path

      # Input JavaScript code that could potentially be executed
      fill_in 'Name', with: 'Normal Item'
      fill_in 'Description', with: '<div><b>Bold Text</b></div>'
      select 'Essential', from: 'Category'
      select 'Decorations', from: 'Essential Type'

      click_button 'Create Item'

      # Check that JavaScript tags are not executed
      expect(page).not_to have_selector('b', text: 'Bold Text')
      expect(page).to have_content('<div><b>Bold Text</b></div>')
    end
  end

  context 'when testing edge cases with unusual characters' do
    it 'handles unusual characters and does not cause XSS' do
      visit new_item_path

      # Input unusual characters and potential XSS vectors
      fill_in 'Name', with: 'Unusual Characters Test'
      fill_in 'Description', with: '"><svg/onload=alert(1)>'
      select 'Essential', from: 'Category'
      select 'Decorations', from: 'Essential Type'

      click_button 'Create Item'

      # Ensure that the unusual characters are not executed as code
      expect(page).not_to have_content('alert(1)')
      expect(page).to have_content('"><svg/onload=alert(1)>')
    end
  end
end
