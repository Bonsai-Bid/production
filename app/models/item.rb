class Item < ApplicationRecord
  enum category_type: { plant: 1, container: 2, essential: 3 }, _prefix: true
  enum material: { commercial: 1, handmade: 2, disposable: 3, material_other: 4 }, _prefix: true
  enum shape: { lotus: 1, nanban: 2, round: 3, oval: 4, rectangle: 5, bag: 6, shape_other: 7 }, _prefix: true
  enum color: { black: 1, white: 2, natural: 3, blue: 4, green: 5, color_other: 6 }, _prefix: true
  enum origin: { us: 1, japan: 2, china: 3, origin_other: 4 }, _prefix: true
  enum size: { extra_small: 1, small: 2, medium: 3, large: 4, extra_large: 5, extraextra_large: 6, size_other: 7 }, _prefix: true
  enum essential_type: { soil: 1, supplements: 2, decorations: 3, wire: 4, books: 5, stands: 6, tools: 7, essential_other: 8 }, _prefix: true
  enum wire_type: { copper: 1, aluminum: 2, wire_other: 3 }, _prefix: true
  enum species: { azalea: 1, boxwood: 2, cypress: 3, elm: 4, ficus: 5, gingko: 6, juniper: 7, maple: 8, oak: 9, olive: 10, pine: 11, schefflera: 12, tea: 13, species_other: 14 }, _prefix: true
  enum species_category: { deciduous: 1, coniferous: 2, tropical: 3, broadleaf_evergreen: 4, species_category_other: 5 }, _prefix: true
  enum style: { formal_upright: 1, informal_upright: 2, cascade: 3, forest: 4, clump: 5, broom: 6, style_other: 7 }, _prefix: true
  enum stage: { pre_bonsai: 1, development: 2, refinement: 3, specimen: 4, seeds_seedlings: 5 }, _prefix: true
  enum tool_type: { shears: 1, pliers: 2, branch_splitters: 3, cutters: 4, rakes: 5, tool_other: 6 }, _prefix: true

  belongs_to :seller, class_name: 'User'
  has_one :auction, dependent: :destroy
  accepts_nested_attributes_for :auction

  validates :name, presence: true
  validates :description, presence: true

  def auction_show_page
    Auction.find_by(item_id: self.id, seller_id: self.seller_id)
  end

  def self.search(query, user_id)
    where("name LIKE ?", "%#{query}%").where.not(seller_id: user_id)
  end
  private

  def assign_species_category
    category_map = {
      1 => :broadleaf_evergreen, 2 => :broadleaf_evergreen, 3 => :coniferous,
      4 => :deciduous, 5 => :tropical, 6 => :deciduous, 7 => :coniferous,
      8 => :deciduous, 9 => :deciduous, 10 => :broadleaf_evergreen,
      11 => :coniferous, 12 => :tropical, 13 => :tropical, 14 => :other
    }
    self.species_category = category_map[self.species_before_type_cast] if self.species
  end
end
