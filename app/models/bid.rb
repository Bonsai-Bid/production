class Bid < ApplicationRecord
  belongs_to :auction
  belongs_to :bidder, class_name: 'User'

  validates :auction_id, :bidder_id, :bid_amount, presence: true
  validates :bid_amount, numericality: { greater_than: 0 }
  validate :bid_amount_greater_than_current_highest_plus_increment

  private

  def bid_amount_greater_than_current_highest_plus_increment
    return if auction.nil?

    current_highest_bid = auction.current_highest_bid == "no bids" ? auction.starting_price : auction.current_highest_bid
    minimum_bid = current_highest_bid + auction.bid_increment

    if bid_amount < minimum_bid
      errors.add(:bid_amount, "must be greater than the current highest bid plus the bid increment")
    end
  end
end
