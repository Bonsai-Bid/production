require 'rails_helper'

RSpec.describe Item, type: :model do
  describe '#auction_show_page' do
    it 'returns the correct auction based on item and seller IDs' do
      seller = create(:user)
      item = create(:item, seller: seller)
      auction = create(:auction, item: item, seller: seller)

      expect(item.auction_show_page).to eq(auction)
    end
  end

  describe '#set_auction_times' do
    it 'sets auction start and end times based on timing options' do
      item = create(:item) 
      auction = build(:auction, item: item, timing_option: 'list_now', auction_length: 7)

      item.auction = auction
      item.set_auction_times

      expect(item.auction.start_date).to be_within(1.second).of(Time.current)
      expect(item.auction.end_date).to eq(item.auction.start_date + 7.days)
    end

    it 'sets auction times correctly for list_later option' do
      item = create(:item)
      start_date = '2050-09-05'
      start_time = '14:00'
      combined_start = DateTime.parse("#{start_date} #{start_time}")
      auction = build(:auction, item: item, timing_option: 'list_later', start_date: combined_start, auction_length: 5)

      item.auction = auction
      item.auction.set_auction_times

      expect(item.auction.start_date).to eq(combined_start)
      expect(item.auction.end_date).to eq(combined_start + 5.days)
    end
  end

  describe '#combine_date_and_time' do
    it 'combines date and time into a DateTime object' do
      item = build(:item) # Use `build` since this is a private method test
      date = '2024-09-01'
      time = '10:00'
      combined = item.send(:combine_date_and_time, date, time)

      expect(combined).to eq(DateTime.parse("#{date} #{time}"))
    end
  end

  describe '#assign_species_category' do
    it 'assigns correct species category based on species before validation' do
      item = build(:item, category_type: 'plant', species: :azalea)
      item.validate
      expect(item.species_category).to eq('broadleaf_evergreen')
    end

    it 'does not assign species category if species is nil' do
      item = build(:item, species: nil)


      # Check if species_category remains nil
      expect(item.species_category).to be_nil
    end
  end
end
