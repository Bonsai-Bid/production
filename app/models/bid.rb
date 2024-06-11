class Bid < ApplicationRecord
  belongs_to :auction  
  belongs_to :bidder, class_name: 'User'

  validates :auction_id, :bidder_id, :bid_amount, presence: true
  
  validates :bid_amount, numericality: { greater_than: 0 }
  validate :bid_within_auction_time

  private

  def bid_within_auction_time
    return if auction.nil?

    unless auction.active? && auction.start_date <= Time.current && auction.end_date >= Time.current
      errors.add(:base, "Bidding is not open. The auction is scheduled to run from #{auction.start_date.strftime('%Y-%m-%d %H:%M:%S')} to #{auction.end_date.strftime('%Y-%m-%d %H:%M:%S')}.")
    end
  end
end
