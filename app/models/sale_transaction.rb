class SaleTransaction < ApplicationRecord
  enum payment_status: { incomplete: 0, pending: 1, complete: 2 }

  belongs_to :buyer, class_name: 'User'
  belongs_to :seller, class_name: 'User'
  belongs_to :auction
  has_many :feedbacks

  validates :buyer_id, presence: true
  validates :seller_id, presence: true
  validates :auction_id, presence: true
  validates :final_price, presence: true

end
