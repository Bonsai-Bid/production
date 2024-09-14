# spec/features/category_specific_validations_spec.rb

require 'rails_helper'

RSpec.describe 'Category-Specific Validations', type: :feature, js: true do
  let(:user) { create(:user) }

  before do
    login_as(user, scope: :user)
  end

  context 'when validating Plant category' do
    xit 'requires a Container selection if "Plant" is chosen' do
      visit new_item_path

      # Fill in required fields for a Plant category without selecting a container
      fill_in 'Name', with: 'Plant Item'
      fill_in 'Description', with: 'A valid description for a plant'
      select 'Plant', from: 'Category'
      select 'Azalea', from: 'Species'
      select 'Broom', from: 'Style'
      select 'Pre Bonsai', from: 'Stage'

      click_button 'Create Item'

      # Check for validation message about missing container
      expect(page).to have_content('Container must be selected for Plant category')
    end

    xit 'requires all plant-specific fields (species, style, stage) to be filled' do
      visit new_item_path

      # Fill in required fields but leave plant-specific fields empty
      fill_in 'Name', with: 'Incomplete Plant Item'
      fill_in 'Description', with: 'Description missing plant-specific fields'
      select 'Plant', from: 'Category'
      # No selection for species, style, and stage

      click_button 'Create Item'

      # Check for validation messages
      expect(page).to have_content("Species can't be blank")
      expect(page).to have_content("Style can't be blank")
      expect(page).to have_content("Stage can't be blank")
    end
  end

  context 'when validating Essential - Tool category' do
    xit 'requires "Condition" and "Brand" fields to be filled if "Essential - Tool" is chosen' do
      visit new_item_path

      # Fill in required fields for an Essential - Tool category without specifying condition and brand
      fill_in 'Name', with: 'Tool Item'
      fill_in 'Description', with: 'A valid description for a tool'
      select 'Essential', from: 'Category'
      select 'Tool', from: 'Essential Type'

      click_button 'Create Item'

      # Check for validation messages about missing condition and brand
      expect(page).to have_content("Condition can't be blank")
      expect(page).to have_content("Brand can't be blank")
    end
  end

  context 'when testing edge cases' do
    xit 'attempts to save a "Plant" item without selecting a container' do
      visit new_item_path

      # Fill in fields for a Plant item but omit the container
      fill_in 'Name', with: 'Edge Case Plant'
      fill_in 'Description', with: 'Edge case: missing container'
      select 'Plant', from: 'Category'
      select 'Azalea', from: 'Species'
      select 'Broom', from: 'Style'
      select 'Pre Bonsai', from: 'Stage'
      # Container is not selected

      click_button 'Create Item'

      # Check that the appropriate validation error is displayed
      expect(page).to have_content('Container must be selected for Plant category')
    end

    xit 'attempts to save an "Essential - Tool" item without specifying condition or brand' do
      visit new_item_path

      # Fill in fields for an Essential - Tool item but omit condition and brand
      fill_in 'Name', with: 'Edge Case Tool'
      fill_in 'Description', with: 'Edge case: missing condition and brand'
      select 'Essential', from: 'Category'
      select 'Tool', from: 'Essential Type'
      # Condition and Brand are not filled

      click_button 'Create Item'

      # Check that the appropriate validation errors are displayed
      expect(page).to have_content("Condition can't be blank")
      expect(page).to have_content("Brand can't be blank")
    end
  end
end
