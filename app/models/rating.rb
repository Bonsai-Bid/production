class Rating < ApplicationRecord
  belongs_to :user_profile

  validates :rating_type, inclusion: { in: %w[seller buyer] }
  validates :rating_value, presence: true, numericality: { greater_than_or_equal_to: 0, less_than_or_equal_to: 5 }
end
