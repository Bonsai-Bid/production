require 'rails_helper'

RSpec.describe Item, type: :model do
  describe 'edge cases' do
    it 'is invalid with an undefined category_type' do
      expect { build(:item, category_type: :undefined) }.to raise_error(ArgumentError)
    end

    it 'handles nil species gracefully when assigning species category' do
      item = build(:item, species: nil)
      expect { item.send(:assign_species_category) }.not_to raise_error
      expect(item.species_category).to be_nil
    end
  end
end
