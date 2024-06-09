class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable,  :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
          :recoverable, :rememberable, :validatable, :timeoutable
  
  has_one :user_profile, dependent: :destroy
  accepts_nested_attributes_for :user_profile
  has_many :items, foreign_key: 'seller_id'
  has_many :bids, foreign_key: 'bidder_id'
  has_many :feedbacks, foreign_key: 'from_user_id'
  has_many :received_feedbacks, class_name: 'Feedback', foreign_key: 'to_user_id'
  has_many :watchlists, dependent: :destroy
  has_many :purchases, class_name: 'SaleTransaction', foreign_key: 'buyer_id'
  has_many :sales, class_name: 'SaleTransaction', foreign_key: 'seller_id'
  has_many :inquiries, foreign_key: :commenter_id
  has_many :received_inquiries, class_name: 'Inquiry', foreign_key: :seller_id
  has_many :auctions, foreign_key: :seller_id

  # after_create :create_user_profile


  validates :street, :city, :state, :zip, presence: true
  validates :zip, format: { with: /\A\d{5}(-\d{4})?\z/, message: "invalid zip code" }
  

  def watchlist_auctions
    favorites = []
    self.watchlists.each do |favs|
      auction = Auction.find(favs.auction_id)
      favorites << auction
    end
    favorites
  end

  # def create_user_profile
  #   build_user_profile(user_profile_attributes) if user_profile_attributes.present?
  #   user_profile.save(validate: false)
  # end

  def name
    user_profile.name
  end
end
