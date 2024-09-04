require 'rails_helper'

RSpec.describe Item, type: :model do
  describe 'enum handling' do
    it 'defines the correct values for category_type enum' do
      expect(Item.category_types).to include('container' => 1, 'essential' => 2, 'plant' => 3)
    end

    it 'defines the correct values for material enum' do
      expect(Item.materials).to include('commercial' => 1, 'disposable' => 2, 'handmade' => 3, 'material_other' => 4)
    end

    # Add tests for other enums similarly
  end
end
