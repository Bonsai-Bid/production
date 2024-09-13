class Auction < ApplicationRecord
  # include Elasticsearch::Model
  # include Elasticsearch::Model::Callbacks
  # index_name 'auctions'

  enum status: { listed: 0, active: 1, sold: 2, ended: 3 }

  attr_accessor :timing_option, :auction_length, :start_time, :end_time

  belongs_to :item, dependent: :destroy 
  belongs_to :seller, class_name: 'User'
  has_many :bids
  has_many :watchlists
  has_many :inquiries
  has_one :sale_transaction

  attribute :enable_buy_it_now, :boolean, default: false
  attribute :enable_reserve_price, :boolean, default: false

  validates :start_date, :end_date, presence: true
  validates :starting_price, :bid_increment, numericality: { greater_than_or_equal_to: 0 }
  validate :end_date_after_start_date
  validate :start_date_not_in_past, if: :start_date_changed_or_new_record?
  validates :status, presence: true, inclusion: { in: Auction.statuses.keys }
  validates :enable_buy_it_now, inclusion: { in: [true, false] }
  validates :enable_reserve_price, inclusion: { in: [true, false] }

  after_initialize :set_default_status, if: :new_record?
  before_save :set_auction_times

#   def self.search(query, filters = {})
#   filter_conditions = []

#   # Add filters conditionally
#   filter_conditions << { range: { start_date: { lte: filters[:start_date] || 'now' } } } # Filter auctions that started on or before now
#   filter_conditions << { range: { end_date: { gte: filters[:end_date] || 'now' } } }    # Filter auctions that end on or after now
#   filter_conditions << { range: { starting_price: { gte: filters[:min_price] || 0, lte: filters[:max_price] || Float::INFINITY } } } # Price range filter
#   filter_conditions << { term: { enable_buy_it_now: filters[:enable_buy_it_now] } } if filters[:enable_buy_it_now].present? # 'Buy it Now' filter
#   filter_conditions << { term: { enable_reserve_price: filters[:enable_reserve_price] } } if filters[:enable_reserve_price].present? # 'Reserve Price' filter

#   # Build the Elasticsearch query
#   __elasticsearch__.search(
#     {
#       query: {
#         bool: {
#           must: [
#             {
#               multi_match: {
#                 query: query,
#                 fields: ['status']
#               }
#             }
#           ],
#           filter: filter_conditions # Use the built filter conditions array
#         }
#       }
#     }
#   )
# end



  def current_highest_bid
    highest_bid = bids.order(bid_amount: :desc).first
    highest_bid ? highest_bid.bid_amount : nil
  end

  def editable?
    status.to_sym == :listed || status == :listed
  end

  def reserve_met?
    return false unless respond_to?(:reserve_price) && reserve_price.present?
    current_highest_bid.present? && current_highest_bid >= reserve_price
  end

  def auction_active?
    now = Time.current
    start_date <= now && now <= end_date
  end

  def update_status_if_needed
    now = Time.current

    if listed? && auction_active?
      self.status = :active
    elsif active? && end_date < now
      self.status = bids.any? ? :sold : :ended
    elsif sold? && sale_transaction.present?
      self.status = :ended
    end
  end

  def set_auction_times
    # require 'pry'; binding.pry
    auction_length_in_days = auction_length.to_i

    case timing_option
    when 'list_now'
      self.start_date = Time.current
      self.end_date = start_date + auction_length_in_days.days
      self.status = :active
    when 'list_later'
      # require 'pry'; binding.pry
      self.start_date = combine_date_and_time(start_date, start_time)
      self.end_date = start_date + auction_length_in_days.days
      self.status = :listed
    else
      self.end_date = combine_date_and_time(end_date, end_time)
    end
  end

  def listing_name
    item.name
  end

  scope :newest_active, -> { where(status: :active).order(created_at: :desc) }

  def time_left
    time_diff = end_date - Time.current

    if time_diff > 24.hours
      # require 'pry'; binding.pry
      days_left = (time_diff / 1.day).floor
      hours_left = ((time_diff % 1.day) / 1.hour).floor
        if hours_left != 0
          "#{days_left} days, #{hours_left} hours remaining"
        else 
          "#{days_left} days remaining"
        end
    elsif time_diff > 0
      hours_left = (time_diff / 1.hour).floor
      minutes_left = ((time_diff % 1.hour) / 1.minute).floor
      "#{hours_left} hours, #{minutes_left} minutes remaining"
    else
      "Auction ended"
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

  def combine_date_and_time(date, time)
    return unless date.present?
    time.present? ? DateTime.parse("#{date} #{time}") : date.to_datetime
  end
end
