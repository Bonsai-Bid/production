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
    end

    describe '#name' do
      it 'returns the user profile name' do
        user_profile = create(:user_profile, user: user)

        expect(user.name).to eq(user_profile.name)
      end
    end
  end
end
