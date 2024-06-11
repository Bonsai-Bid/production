class UserProfile < ApplicationRecord
  belongs_to :user

  
  validates :name, presence: true
  validates :phone, format: { 
    with: /\A\+?1?\D?(\d{3})\D?\D?(\d{3})\D?(\d{4})\z/, 
    message: "must be a valid phone number" 
  }, presence: true

  before_save :normalize_phone_number

  private

  def normalize_phone_number
    self.phone = PhonyRails.normalize_number(phone, default_country_code: 'US')
  end
end
