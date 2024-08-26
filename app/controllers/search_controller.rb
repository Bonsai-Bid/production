class SearchController < ApplicationController
  def index
    require 'pry'; binding.pry
    @search_term = params[:search].downcase
    @results = search_items_and_auctions(@search_term)

  end

  private

  # def search_items(search_term)
  #   category_terms = map_search_term_to_category(search_term)
  #   Item.where("LOWER(name) LIKE :term OR LOWER(description) LIKE :term OR species_category IN (:categories)", 
  #             term: "%#{search_term}%", categories: category_terms)
  #       .where.not(seller_id: current_user.id)
  # end

  def search_items_and_auctions(search_term)
    category_terms = map_search_term_to_category(search_term)

    # Use Elasticsearch to search both Item and Auction models
    item_results = Item.search(search_term).records.to_a
    auction_results = Auction.search(search_term).records.to_a

    # Filter out results where the seller is the current user
    filtered_items = item_results.reject { |item| item.seller_id == current_user.id }
    
    # Combine results
    filtered_items + auction_results
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
