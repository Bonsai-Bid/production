class UserProfile < ApplicationRecord
  belongs_to :user

  
  # validates :name, presence: true
  # validates :phone, format: { 
  #   with: /\A\+?1?\D?(\d{3})\D?\D?(\d{3})\D?(\d{4})\z/, 
  #   message: "must be a valid phone number" 
  # }, presence: true
  # validates :time_zone, inclusion: { in: ActiveSupport::TimeZone.all.map(&:name) }, presence: true
  has_many :ratings, dependent: :destroy

  has_one_attached :profile_picture
  has_one_attached :banner_image

  # before_save :normalize_phone_number

  def average_seller_rating
    ratings.where(rating_type: 'seller').average(:rating_value).to_f
  end

  def average_buyer_rating
    ratings.where(rating_type: 'buyer').average(:rating_value).to_f
  end

  # private

  # def normalize_phone_number
  #   self.phone = PhonyRails.normalize_number(phone, default_country_code: 'US')
  # end
end
