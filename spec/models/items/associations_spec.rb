require 'rails_helper'

RSpec.describe Item, type: :model do
  describe 'associations' do
    it { should belong_to(:seller).class_name('User') }
    it { should have_one(:auction).dependent(:destroy) }
  end
end
