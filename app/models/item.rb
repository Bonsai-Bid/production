class Item < ApplicationRecord
  include EnumNilHandler
  # include Elasticsearch::Model
  # include Elasticsearch::Model::Callbacks


  enum category_type: { container: 1, essential: 2, plant: 3 }, _prefix: true
  enum material: { commercial: 1, disposable: 2, handmade: 3, material_other: 4 }, _prefix: true
  enum shape: { bag: 1, lotus: 2, nanban: 3, oval: 4, rectangle: 5, round: 6, shape_other: 7 }, _prefix: true
  enum color: { black: 1, blue: 2, green: 3, natural: 4, white: 5, color_other: 6 }, _prefix: true
  enum origin: { china: 1, japan: 2, us: 3, origin_other: 4 }, _prefix: true
  enum size: { extra_small: 1, small: 2, medium: 3, large: 4, extra_large: 5, extraextra_large: 6, size_other: 7 }, _prefix: true
  enum essential_type: { books: 1, decorations: 2, soil: 3, stands: 4, supplements: 5, tool: 6, wire: 7, essential_other: 8 }, _prefix: true
  enum wire_type: { aluminum: 1, copper: 2, wire_other: 3 }, _prefix: true
  enum species: { azalea: 1, boxwood: 2, cypress: 3, elm: 4, ficus: 5, gingko: 6, juniper: 7, maple: 8, oak: 9, olive: 10, pine: 11, schefflera: 12, tea: 13, species_other: 14 }, _prefix: true
  enum species_category: { broadleaf_evergreen: 1, coniferous: 2, deciduous: 3, tropical: 4, species_category_other: 5 }, _prefix: true
  enum style: { broom: 1, cascade: 2, clump: 3, formal_upright: 4, forest: 5, informal_upright: 6, style_other: 7 }, _prefix: true
  enum stage: { pre_bonsai: 1, development: 2, refinement: 3, specimen: 4, seeds_seedlings: 5 }, _prefix: true
  enum tool_type: { branch_splitters: 1, cutters: 2, pliers: 3, rakes: 4, shears: 5, tool_other: 6 }, _prefix: true
  enum condition: { new: 1, good: 2, fair: 3, poor: 4 }, _prefix: true 

  
  has_many_attached :images
  belongs_to :seller, class_name: 'User'
  has_one :auction, dependent: :destroy
  accepts_nested_attributes_for :auction

  validates :name, presence: true
  validates :description, presence: true

  before_validation :assign_species_category, if: -> { species.present? }

  def auction_show_page
    Auction.find_by(item_id: self.id, seller_id: self.seller_id)
  end

  # def self.search(query, user_id)
  #   where("name LIKE ?", "%#{query}%").where.not(seller_id: user_id)
  # end

  def thumbnail
    images.map do |image|
      variant = image.variant(resize_to_limit: [300, 300]).processed
      Rails.logger.debug "Thumbnail variant: #{variant.inspect}"
      variant
    end
  end

  def compressed_images
    images.map do |image|
      image.variant(resize_to_limit: [1200, 1200], quality: 80).processed
    end
  end


  def display_image
    variant = images.first.variant(resize_to_limit: [300, 300]).processed
    Rails.logger.debug "Display image variant: #{variant.inspect}"
    variant
  end

  def set_auction_times
    if auction.timing_option == 'list_now'
      auction.start_date = Time.current
      auction.end_date = auction.start_date + auction.auction_length.days
    elsif auction.timing_option == 'list_later'
      auction.start_date = combine_date_and_time(auction.start_date, auction.start_time)
      auction.end_date = auction.start_date + auction.auction_length.days
    else
      auction.end_date = combine_date_and_time(auction.end_date, auction.end_time)
    end
  end

  with_options if: -> { category_type == 'plant' } do
    validates :species, presence: true
    validates :style, presence: true
    validates :stage, presence: true
    # Validate container too
    validates :material, presence: true
    validates :shape, presence: true
    validates :color, presence: true
    validates :origin, presence: true
    validates :size, presence: true
  end

  with_options if: -> { category_type == 'container' } do
    validates :material, presence: true
    validates :shape, presence: true
    validates :color, presence: true
    validates :origin, presence: true
    validates :size, presence: true
  end

  with_options if: -> { category_type == 'essential' } do
    validates :essential_type, presence: true
    validates :wire_type, presence: true, if: -> { essential_type == 'wire' }
    validates :tool_type, presence: true, if: -> { essential_type == 'tool' }
    validates :brand, presence: true, if: -> { essential_type == 'tool' }
    validates :condition, presence: true, if: -> { essential_type == 'tool' }
  end

  # Validate other fields when needed
  validates :material_other, presence: true, if: -> { material == 'material_other' }
  validates :shape_other, presence: true, if: -> { shape == 'shape_other' }
  validates :color_other, presence: true, if: -> { color == 'color_other' }
  validates :origin_other, presence: true, if: -> { origin == 'origin_other' }
  validates :essential_other, presence: true, if: -> { essential_type == 'essential_other' }
  validates :wire_other, presence: true, if: -> { wire_type == 'wire_other' }
  validates :species_other, presence: true, if: -> { species == 'species_other' }
  validates :style_other, presence: true, if: -> { style == 'style_other' }
  validates :size_other, presence: true, if: -> { size == 'size_other' }
  validates :tool_other, presence: true, if: -> { tool_type == 'tool_other' }



  private

  def combine_date_and_time(date, time)
    DateTime.parse("#{date} #{time}")
  end

  def assign_species_category
      return if species.blank? || !Item.species.keys.include?(species)
  
    category_map = {
      azalea: :broadleaf_evergreen, boxwood: :broadleaf_evergreen, cypress: :coniferous,
      elm: :deciduous, ficus: :tropical, gingko: :deciduous, juniper: :coniferous,
      maple: :deciduous, oak: :deciduous, olive: :broadleaf_evergreen,
      pine: :coniferous, schefflera: :tropical, tea: :tropical, species_other: :species_category_other
    }
  
    species_symbol = species.to_sym

    if category_map.key?(species_symbol)
      self.species_category = category_map[species_symbol]
    end
  end
  

  def image_type
    images.each do |image|
      if !image.blob.content_type.in?(%('image/jpeg image/png'))
        errors.add(:images, 'needs to be a JPEG or PNG')
      end
    end
  end
end
