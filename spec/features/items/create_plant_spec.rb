# spec/features/items/create_spec.rb

require 'rails_helper'

RSpec.describe 'Create Item', type: :feature, js: true do
  let(:user) { create(:user) }

  before do
    sign_in user
  end

  describe 'Creating a Plant Item' do
    context 'with valid inputs including "Other" options' do
      it 'creates a new plant item with all required fields including "Other" inputs' do
        visit new_item_path
        fill_in 'Name', with: 'Test Plant Item with Others'
        fill_in 'Description', with: 'A description of the test plant item'
        select 'Plant', from: 'Category'

        # Ensure plant fields are visible
        expect(page).to have_selector('#plant_fields', visible: true)
        within('#plant_fields') do
          select 'Species other', from: 'Species'
          fill_in 'Other Species', with: 'Custom Species'
          select 'Style other', from: 'Style'
          fill_in 'Other Style', with: 'Custom Style'

          select 'Development', from: 'Stage' # Use a valid enum here
        end

        # Ensure container fields are visible and fill them
        expect(page).to have_selector('#container_fields', visible: true)
        within('#container_fields') do
          select 'Other', from: 'Material'
          fill_in 'Other Material', with: 'Custom Material'

          select 'Other', from: 'Shape'
          fill_in 'Other Shape', with: 'Custom Shape'

          select 'Other', from: 'Color'
          fill_in 'Other Color', with: 'Custom Color'

          select 'Other', from: 'Origin'
          fill_in 'Other Origin', with: 'Custom Origin'

          select 'Other', from: 'Size'
          fill_in 'Other Size', with: 'Custom Size'
        end

        # Fill auction details
        fill_in 'Starting Price', with: '50'
        fill_in 'Minimum Bid Increment', with: '5'

        # Handle the Buy It Now option
        expect(page).to have_selector('#enable_buy_it_now', visible: true)
        find('#enable_buy_it_now').click
        expect(page).to have_selector('#buy_it_now_price_field', visible: true)
        fill_in 'Buy It Now Price', with: '100'

        click_button 'Create Item'
        expect(page).to have_current_path(dashboard_user_path(user))
        expect(page).to have_content('Item and associated auction were successfully created.')

        # Verify the item was created with "Other" values correctly
        item = Item.last
        expect(item.name).to eq('Test Plant Item with Others')
        expect(item.species).to eq('species_other')
        expect(item.species_other).to eq('Custom Species')
        expect(item.style).to eq('style_other')
        expect(item.style_other).to eq('Custom Style')
        expect(item.material).to eq('material_other')
        expect(item.material_other).to eq('Custom Material')
        expect(item.shape).to eq('shape_other')
        expect(item.shape_other).to eq('Custom Shape')
        expect(item.color).to eq('color_other')
        expect(item.color_other).to eq('Custom Color')
        expect(item.origin).to eq('origin_other')
        expect(item.origin_other).to eq('Custom Origin')
        expect(item.size).to eq('size_other')
        expect(item.size_other).to eq('Custom Size')
      end
    end

    context 'with missing required fields' do
      it 'shows HTML5 validation messages' do
        visit new_item_path
        fill_in 'Name', with: '' # Clear name field to trigger validation

        # Attempt to submit the form
        click_button 'Create Item'

        # Check if the name field is marked as invalid
        valid = page.evaluate_script("document.querySelector('#item_name').validity.valid")
        validation_message = page.evaluate_script("document.querySelector('#item_name').validationMessage")

        # Expectations
        expect(valid).to be false
        expect(validation_message).to include('Please fill out this field')
      end
    end

    context 'with all enum options for plant category including "Other"' do
      let(:species) { Item.species.keys }
      let(:styles) { Item.styles.keys }
      let(:stages) { Item.stages.keys }
      let(:materials) { Item.materials.keys }
      let(:shapes) { Item.shapes.keys }
      let(:colors) { Item.colors.keys }
      let(:origins) { Item.origins.keys }
      let(:sizes) { Item.sizes.keys }
    
      xit 'tests all combinations of enums including "Other" for plant fields' do
        species.each do |specie|
          styles.each do |style|
            stages.each do |stage|
              visit new_item_path
              fill_in 'Name', with: "Test Item #{specie} #{style} #{stage}"
              fill_in 'Description', with: 'A detailed description'
    
              select 'Plant', from: 'Category'
              within('#plant_fields') do
                select specie.humanize, from: 'Species'
                fill_in 'Other Species', with: 'Custom Species' if specie == 'species_other'
    
                select style.humanize, from: 'Style'
                fill_in 'Other Style', with: 'Custom Style' if style == 'style_other'
    
                select stage.humanize, from: 'Stage'
              end
    
              # Fill container fields
              within('#container_fields') do
                select materials.include?('material_other') ? 'Other' : materials.sample.humanize, from: 'Material'
                fill_in 'Other Material', with: 'Custom Material' if materials.include?('material_other') && 'material_other'.in?(materials)
    
                select shapes.include?('shape_other') ? 'Other' : shapes.sample.humanize, from: 'Shape'
                fill_in 'Other Shape', with: 'Custom Shape' if shapes.include?('shape_other') && 'shape_other'.in?(shapes)
    
                select colors.include?('color_other') ? 'Other' : colors.sample.humanize, from: 'Color'
                fill_in 'Other Color', with: 'Custom Color' if colors.include?('color_other') && 'color_other'.in?(colors)
    
                select origins.include?('origin_other') ? 'Other' : origins.sample.humanize, from: 'Origin'
                fill_in 'Other Origin', with: 'Custom Origin' if origins.include?('origin_other') && 'origin_other'.in?(origins)
    
                select sizes.include?('size_other') ? 'Other' : sizes.sample.humanize, from: 'Size'
                fill_in 'Other Size', with: 'Custom Size' if sizes.include?('size_other') && 'size_other'.in?(sizes)
              end
    
              # Fill auction details
              fill_in 'Starting Price', with: '50'
              fill_in 'Minimum Bid Increment', with: '5'
    
              click_button 'Create Item'
              expect(page).to have_current_path(dashboard_user_path(user))
              expect(page).to have_content('Item and associated auction were successfully created.')
            end
          end
        end
      end
    end    
  end
end
