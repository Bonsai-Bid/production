class Bid < ApplicationRecord
  belongs_to :auction  
  belongs_to :bidder, class_name: 'User'

  validates :auction_id, :bidder_id, :bid_amount, presence: true
  
  validates :bid_amount, numericality: { greater_than: 0 }
  # validate :bid_within_auction_time

  private

  

  # def bid_within_auction_time
  #   return if auction.nil? || bid_time.blank?

  #   if bid_time < auction.start_date || bid_time > auction.end_date
  #     errors.add(:bid_time, "must be within the auction's start and end times")
  #   end
  # end
end
