class UserProfile < ApplicationRecord
  belongs_to :user

  
  validates :name, presence: true
  validates :phone, format: { with: /\A\D?(\d{3})\D?\D?(\d{3})\D?(\d{4})\z/, message: "must be a 10 digit number" }, presence: true

end
