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

  after_create :create_user_profile
  validate :reject_suspicious_sql_patterns
  validate :password_complexity
  validates :first_name, :last_name, presence: true, length: { maximum: 50 }
  validates :street, :city, presence: true, length: { maximum: 100 }
  validates :state, presence: true, length: { maximum: 50 } 
  validates :zip, presence: true, length: { maximum: 10 }, format: { with: /\A\d{5}(-\d{4})?\z/, message: "invalid zip code" }
  validates :phone, presence: true, length: { maximum: 15 }, format: { 
    with: /\A\+?1?\D?(\d{3})\D?\D?(\d{3})\D?(\d{4})\z/, 
    message: "must be a valid phone number" 
  }
  validates :time_zone, inclusion: { in: ActiveSupport::TimeZone.all.map(&:name) }, presence: true
  validates :email, length: { maximum: 255 }

  def watchlist_auctions
    favorites = []
    self.watchlists.each do |favs|
      auction = Auction.find(favs.auction_id)
      favorites << auction
    end
    favorites
  end

  def create_user_profile
    display_name = "#{first_name} #{last_name}"
    location = "#{city}, #{state}"
    UserProfile.create!(user: self, name: display_name, location: location)
  end

  def name
    user_profile.name
  end

  private

  def password_complexity
    # Regex to check for at least one special character
    return if password.blank? || password =~ /[^A-Za-z0-9]/

    errors.add :password, 'must include at least one special character (e.g. !@#$%^&*)'
  end

  def reject_suspicious_sql_patterns
    # Expanded list of patterns to match common SQL injection techniques
    patterns = [
      /['"]+/,             # Single or double quotes
      /--|#/,              # SQL comment indicators
      /;/,                 # Semicolons for query termination
      /\b(SELECT|UNION|INSERT|UPDATE|DELETE|DROP|ALTER)\b/i, # SQL keywords
      /\b(OR|AND)\b.*\b(=|LIKE|IS)\b/i, # Logical operators with conditions
      /\b(=|LIKE|IS)\b/,   # Equality and comparison operators
      /[\(\)]/,            # Parentheses for SQL functions
      /\/\*|\*\//          # Inline comments or concatenation
    ]
    
    # Check fields for patterns
    fields_to_check = [first_name, last_name, street, city, zip] # Add other fields as needed

    fields_to_check.each do |field|
      patterns.each do |pattern|
        if field.present? && field.match?(pattern)
          errors.add(:base, 'contains invalid characters')
        end
      end
    end
  end

  def normalize_phone_number
    self.phone = PhonyRails.normalize_number(phone, default_country_code: 'US')
  end
end
