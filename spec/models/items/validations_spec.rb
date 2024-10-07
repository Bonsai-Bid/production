require 'rails_helper'

RSpec.describe Item, type: :model do
  describe 'validations' do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:description) }

    context 'category-specific validations' do
      it 'validates required fields for plant category' do
        item = build(:item, category_type: :plant)
        item.species = nil
        item.style = nil
        item.stage = nil
        expect(item).not_to be_valid
        expect(item.errors[:species]).to include("can't be blank")
        expect(item.errors[:style]).to include("can't be blank")
        expect(item.errors[:stage]).to include("can't be blank")
      end

      it 'validates required fields for container category' do
        item = build(:item, category_type: :container)
        item.material = nil
        item.shape = nil
        item.color = nil
        item.origin = nil
        item.size = nil
        expect(item).not_to be_valid
        expect(item.errors[:material]).to include("can't be blank")
        expect(item.errors[:shape]).to include("can't be blank")
        expect(item.errors[:color]).to include("can't be blank")
        expect(item.errors[:origin]).to include("can't be blank")
        expect(item.errors[:size]).to include("can't be blank")
      end

      it 'validates required fields for essential category' do
        item = build(:item, category_type: :essential)
        item.essential_type = nil
        expect(item).not_to be_valid
        expect(item.errors[:essential_type]).to include("can't be blank")
  
        item.essential_type = :wire
        item.wire_type = nil
        expect(item).not_to be_valid
        expect(item.errors[:wire_type]).to include("can't be blank")
  
        item.essential_type = :tool
        item.tool_type = nil
        expect(item).not_to be_valid
        expect(item.errors[:tool_type]).to include("can't be blank")
      end  
    end

    context 'other fields validations' do
      it 'requires other fields to be filled when selected' do
        item = build(:item, material: :material_other)
        item.material_other = nil
        expect(item).not_to be_valid
        expect(item.errors[:material_other]).to include("can't be blank")
      end
    end
  end
end
