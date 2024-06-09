class Feedback < ApplicationRecord
  belongs_to :auction
  belongs_to :from_user, class_name: 'User'
  belongs_to :to_user, class_name: 'User'
  belongs_to :sale_transaction
  has_many :replies, as: :respondable, dependent: :destroy

  validates :rating, presence: true, inclusion: { in: 1..5 }
  validates :comment, presence: true
  

end
