require 'rails_helper'

RSpec.feature "Item Creation - Other Fields Visibility", type: :feature, js: true do
  let(:user) { create(:user) }

  before do
    login_as(user, scope: :user)
    visit new_item_path
  end

  describe 'selecting Other options' do
    it 'displays the Other fields for material, shape, color, size, and origin when the category is "Container"' do
      # Select "Container" as the category
      select 'Container', from: 'item_category_type'

      # Material
      select 'Other', from: 'item_material'
      expect(page).to have_selector('#item_material_other', visible: true)

      # Shape
      select 'Other', from: 'item_shape'
      expect(page).to have_selector('#item_shape_other', visible: true)

      # Color
      select 'Other', from: 'item_color'
      expect(page).to have_selector('#item_color_other', visible: true)

      # Size
      select 'Other', from: 'item_size'
      expect(page).to have_selector('#item_size_other', visible: true)

      # Origin
      select 'Other', from: 'item_origin'
      expect(page).to have_selector('#item_origin_other', visible: true)
    end

    it 'displays the Other field for essential type when "Other" is selected and the category is "Essential"' do
      # Select "Essential" as the category
      select 'Essential', from: 'item_category_type'

      # Essential Type
      select 'Other', from: 'item_essential_type'
      expect(page).to have_selector('#item_essential_other', visible: true)
    end

    it 'displays the Other field for wire type when "Other" is selected and the category is "Essential"' do
      # Select "Essential" as the category
      select 'Essential', from: 'item_category_type'

      # Select "Wire" from the Essential Type dropdown
      select 'Wire', from: 'item_essential_type'
      
      # Check if the Wire fields are visible
      expect(page).to have_selector('#wire_fields', visible: true)

      # Select "Other" from the Wire Type dropdown
      select 'Other', from: 'item_wire'
      expect(page).to have_selector('#item_wire_other', visible: true)
    end

    it 'displays the Other field for tool type when "Other" is selected and the category is "Essential"' do
      # Select "Essential" as the category
      select 'Essential', from: 'item_category_type'

      # Select "Tools" from the Essential Type dropdown
      select 'Tools', from: 'item_essential_type'

      # Check if the Tools fields are visible
      expect(page).to have_selector('#tools_fields', visible: true)

      # Select "Other" from the Tool Type dropdown
      select 'Other', from: 'item_tool'
      expect(page).to have_selector('#item_tool_other', visible: true)
    end

    it 'displays the Other field for species when "Other" is selected and the category is "Plant"' do
      # Select "Plant" as the category
      select 'Plant', from: 'item_category_type'

      # Species
      select 'Species other', from: 'item_species'
      expect(page).to have_selector('#item_species_other', visible: true)
    end

    it 'displays the Other field for style when "Other" is selected and the category is "Plant"' do
      # Select "Plant" as the category
      select 'Plant', from: 'item_category_type'

      # Style
      select 'Style other', from: 'item_style'
      expect(page).to have_selector('#item_style_other', visible: true)
    end
  end
end
