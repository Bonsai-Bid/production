class Auction < ApplicationRecord
  enum status: { listed: 0, active: 1, sold: 2, ended: 3 }

  belongs_to :item, dependent: :destroy 
  belongs_to :seller, class_name: 'User'
  has_many :bids
  has_many :watchlists
  has_many :inquiries
  has_one :sale_transaction

  validates :start_date, :end_date, presence: true
  validates :starting_price, :bid_increment, numericality: { greater_than_or_equal_to: 0 }
  validate :end_date_after_start_date
  validate :start_date_not_in_past, if: :start_date_changed_or_new_record?
  validates :status, presence: true, inclusion: { in: Auction.statuses.keys }

  after_initialize :set_default_status, if: :new_record?

  def current_highest_bid
    highest_bid = bids.order(bid_amount: :desc).first
    highest_bid ? highest_bid.bid_amount : "no bids"
  end

  def auction_active?
    now = Time.now
    start_date <= now && now <= end_date
  end

  def update_status_if_needed
    now = Time.now

    if self.status == "listed" && start_date <= now && now <= end_date
      self.status = :active
    elsif self.status == "active" && end_date < now
      if bids.any?
        self.status = :sold
      else
        self.status = :ended
      end
    elsif self.status == "sold" && sale_transaction.present?
      self.status = :ended
    end
  end
  private

  def end_date_after_start_date
    return if end_date.blank? || start_date.blank?

    errors.add(:end_date, "must be after the start date") if end_date < start_date
  end

  def start_date_not_in_past
    return if start_date.blank?

    errors.add(:start_date, "cannot be in the past") if start_date < Date.today
  end

  def start_date_changed_or_new_record?
    new_record? || start_date_changed?
  end

  def set_default_status
    self.status ||= :listed
  end

end
