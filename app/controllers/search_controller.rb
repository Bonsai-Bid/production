class SearchController < ApplicationController
  def index
    @search_term = params[:search].downcase
    results = search_items(@search_term)
  
    @results = results[:items]        # Active items excluding the current user's items
    @ended_results = results[:ended_items]  # Ended items excluding the current user's items
    @my_items = results[:my_items]    # Active items belonging to the current user
    @my_ended_items = results[:my_ended_items] # Ended items belonging to the cur
  end

  private

  def search_items(search_term)
    category_terms = map_search_term_to_category(search_term)
  
    # Fetch all relevant items in one query
    items = Item.where("LOWER(name) LIKE :term OR LOWER(description) LIKE :term", term: "%#{search_term}%")
    items = items.where("species_category IN (:categories)", categories: category_terms) unless category_terms.empty?
  
    # Partition the items into those belonging to the current user and those that don't
    my_items, other_items = items.partition { |item| item.seller_id == current_user.id }
  
    # Further partition items by auction status (assuming auction status 3 means 'ended')
    my_active_items, my_ended_items = my_items.partition { |item| item.auction.status != 2 && item.auction.status != 3 }
    other_active_items, other_ended_items = other_items.partition { |item| item.auction.status != 2 && item.auction.status != 3 }
  
    {
      items: other_active_items,
      ended_items: other_ended_items,
      my_items: my_active_items,
      my_ended_items: my_ended_items
    }
  end
  

  def map_search_term_to_category(term)
    category_mapping = {
      'deciduous' => Item.species_categories[:deciduous],
      'coniferous' => Item.species_categories[:coniferous],
      'tropical' => Item.species_categories[:tropical],
      'broadleaf evergreen' => Item.species_categories[:broadleaf_evergreen],
      'other' => Item.species_categories[:other]
    }

    category_mapping.keys.filter { |k| k.include?(term) }.map { |k| category_mapping[k] }
  end
end