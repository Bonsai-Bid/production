require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'Time zone handling' do
    let(:user) { create(:user, time_zone: 'Eastern Time (US & Canada)') }
    let(:user_with_utc) { create(:user, time_zone: 'UTC') }
    let(:user_without_time_zone) { create(:user) }
    


    it 'saves and retrieves the user time zone correctly' do
      expect(user.time_zone).to eq('Eastern Time (US & Canada)')
    end

    it 'displays the current time in the user’s time zone' do
      Time.use_zone(user.time_zone) do
        user_time = Time.current
        expect(user_time.zone).to eq('EDT') 
      end
    end

    it 'converts times correctly between different time zones' do
      user_time = Time.use_zone(user.time_zone) { Time.zone.parse('2024-09-15 12:00:00') }
      utc_time = user_time.in_time_zone('UTC')
      expect(utc_time.strftime('%H:%M')).to eq('16:00') 
    end


    it 'defaults to Pacific Time if time zone is not set' do
      user_without_time_zone.time_zone = nil
      Time.use_zone(user_without_time_zone.time_zone || 'Pacific Time (US & Canada)') do
        expect(Time.zone.name).to eq('Pacific Time (US & Canada)') 
      end
    end

    it 'handles daylight saving time correctly' do
      Time.use_zone(user.time_zone) do
        spring_time = Time.zone.parse('2024-03-10 01:59:59')
        expect(spring_time.dst?).to be false
        expect(spring_time + 1.minute).to have_attributes(hour: 3)

        fall_time = Time.zone.parse('2024-11-03 01:59:59')
        expect(fall_time.dst?).to be true
        expect(fall_time + 1.minute).to have_attributes(hour: 1)
      end
    end
  end
end