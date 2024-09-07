require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) { create(:user) }

  describe 'methods' do
    describe '#watchlist_auctions' do
      it 'returns the favorite auctions' do
        auction1 = create(:auction)
        auction2 = create(:auction)
        create(:watchlist, user: user, auction: auction1)
        create(:watchlist, user: user, auction: auction2)

        expect(user.watchlist_auctions).to contain_exactly(auction1, auction2)
      end
    end

    describe '#create_user_profile' do
      it 'creates a user profile with name and location' do
        user.reload
        expect(user.user_profile.name).to eq("#{user.first_name} #{user.last_name}")
        expect(user.user_profile.location).to eq("#{user.city}, #{user.state}")
      end

      it 'prevents creating multiple user profiles for the same user' do
        # Try to create another user profile for the same user
        expect {
          UserProfile.create!(user: user, name: 'Duplicate Profile', location: 'Duplicate Location')
        }.to raise_error(ActiveRecord::RecordNotUnique, /duplicate key value violates unique constraint/)
      end
    end

    describe '#name' do
      it 'returns the user profile name' do
        user_profile = user.user_profile

        expect(user.name).to eq(user_profile.name)
      end
    end
    describe '#normalize_phone_number' do
    context 'with valid US phone numbers' do
      it 'normalizes a standard 10-digit number' do
        user.phone = '3031234567'
        user.send(:normalize_phone_number)
        expect(user.phone).to eq('+13031234567')
      end

      it 'normalizes a number with US country code' do
        user.phone = '+13031234567'
        user.send(:normalize_phone_number)
        expect(user.phone).to eq('+13031234567')
      end

      it 'normalizes a number with formatting characters' do
        user.phone = '(303) 123-4567'
        user.send(:normalize_phone_number)
        expect(user.phone).to eq('+13031234567')
      end
    end

    context 'with invalid phone numbers' do
      it 'returns nil for empty phone numbers' do
        user.phone = ''
        user.send(:normalize_phone_number)
        expect(user.phone).to eq(nil)
      end

      it 'returns nil for non-numeric values' do
        user.phone = 'invalidphone'
        user.send(:normalize_phone_number)
        expect(user.phone).to eq(nil)
      end

      it 'does not normalize nil values' do
        user.phone = nil
        user.send(:normalize_phone_number)
        expect(user.phone).to be_nil
      end
    end

    context 'with edge cases' do
      it 'handles too short numbers gracefully' do
        user.phone = '123'
        user.send(:normalize_phone_number)
        expect(user.phone).to eq('+123') # Based on how PhonyRails handles short input
      end
    end
  end
  end
end
