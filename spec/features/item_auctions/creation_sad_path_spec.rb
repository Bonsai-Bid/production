
require 'rails_helper'

RSpec.feature "Item Creation - Sad Path", type: :feature, js: true do
  let(:user) { create(:user) }

  before do
    login_as(user, scope: :user)
  end
  scenario 'form should not submit when no fields are filled' do
    visit new_item_path

    # Submit form without filling any fields
    click_button 'Create Item'

    # Check validation for missing name
    name_valid = page.evaluate_script("document.querySelector('#item_name').validity.valid")
    name_validation_message = page.evaluate_script("document.querySelector('#item_name').validationMessage")
    expect(name_valid).to be false
    expect(name_validation_message).to include('Please fill out this field')

    # Check validation for missing category
    category_type_valid = page.evaluate_script("document.querySelector('#item_category_type').validity.valid")
    category_type_validation_message = page.evaluate_script("document.querySelector('#item_category_type').validationMessage")
    expect(category_type_valid).to be false
    expect(category_type_validation_message).to include('Please select an item in the list.')
  end



  scenario 'form should not submit when material is missing for container category' do
    visit new_item_path
  
    fill_in 'item_name', with: 'Ceramic Pot'
    fill_in 'item_description', with: 'Ceramic Pot that has no material'
    select 'Container', from: 'item_category_type'
    select 'Round', from: 'item_container_shape'
    select 'Blue', from: 'item_container_color'
    select 'China', from: 'item_container_origin'
    select 'Small', from: 'item_container_size'
  
    # Submit form
    click_button 'Create Item'
  
    # Check validation for missing material
    material_valid = page.evaluate_script("document.querySelector('#item_container_material').validity.valid")
    material_validation_message = page.evaluate_script("document.querySelector('#item_container_material').validationMessage")
    expect(material_valid).to be false
    expect(material_validation_message).to include('Please select an item in the list.')
  end

  scenario 'form should not submit when species_other is required but missing' do
    visit new_item_path
  
    # Select "Other" for species
    fill_in 'item_name', with: 'Beautiful Bonsai'
    select 'Plant', from: 'item_category_type'
    select 'Species other', from: 'item_plant_species'
    select 'Formal upright', from: 'item_plant_style'
    select 'Development', from: 'item_plant_stage'
  
    # Submit form
    click_button 'Create Item'
  
    # Check validation for missing species_other
    species_other_valid = page.evaluate_script("document.querySelector('#item_species_other').validity.valid")
    species_other_validation_message = page.evaluate_script("document.querySelector('#item_species_other').validationMessage")
    expect(species_other_valid).to be false
    expect(species_other_validation_message).to include('Please fill out this field')
  end

  scenario 'form should not submit when tool_other is required but missing' do
    visit new_item_path
  
    # Select "Other" for tool
    fill_in 'item_name', with: 'Bonsai Shears'
    select 'Essential', from: 'item_category_type'
    select 'Tool', from: 'item_essential_type'
    select 'Other', from: 'item_tool'
    fill_in 'item_brand', with: 'BonsaiMaster'
    select 'New', from: 'item_condition'
  
    # Submit form
    click_button 'Create Item'
  
    # Check validation for missing tool_other
    tool_other_valid = page.evaluate_script("document.querySelector('#item_tool_other').validity.valid")
    tool_other_validation_message = page.evaluate_script("document.querySelector('#item_tool_other').validationMessage")
    expect(tool_other_valid).to be false
    expect(tool_other_validation_message).to include('Please fill out this field')
  end

  scenario 'form should not submit when wire_type is missing for essential type wire' do
    visit new_item_path
  
    # Select essential category and wire type
    fill_in 'item_name', with: 'Bonsai Wire'
    fill_in 'item_description', with: 'Bonsai Wire Description'
    select 'Essential', from: 'item_category_type'
    select 'Wire', from: 'item_essential_type'
  
    # Submit form without selecting wire type
    click_button 'Create Item'
  
    # Check validation for missing wire_type
    wire_type_valid = page.evaluate_script("document.querySelector('#item_wire').validity.valid")
    wire_type_validation_message = page.evaluate_script("document.querySelector('#item_wire').validationMessage")
    expect(wire_type_valid).to be false
    expect(wire_type_validation_message).to include('Please select an item in the list.')
  end
  
  
end


