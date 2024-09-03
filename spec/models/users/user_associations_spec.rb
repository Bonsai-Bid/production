require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'associations' do
    it { should have_one(:user_profile).dependent(:destroy) }
    it { should accept_nested_attributes_for(:user_profile) }

    it { should have_many(:items).with_foreign_key('seller_id') }
    it { should have_many(:bids).with_foreign_key('bidder_id') }
    it { should have_many(:feedbacks).with_foreign_key('from_user_id') }
    it { should have_many(:received_feedbacks).class_name('Feedback').with_foreign_key('to_user_id') }
    it { should have_many(:watchlists).dependent(:destroy) }
    it { should have_many(:purchases).class_name('SaleTransaction').with_foreign_key('buyer_id') }
    it { should have_many(:sales).class_name('SaleTransaction').with_foreign_key('seller_id') }
    it { should have_many(:inquiries).with_foreign_key(:commenter_id) }
    it { should have_many(:received_inquiries).class_name('Inquiry').with_foreign_key(:seller_id) }
    it { should have_many(:auctions).with_foreign_key(:seller_id) }
  end
end
