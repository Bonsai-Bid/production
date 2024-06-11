class SearchController < ApplicationController
  def index
    @search_term = params[:query].downcase
    @results = search_items(@search_term)
  end

  private

  def search_items(search_term)
    category_terms = map_search_term_to_category(search_term)
    Item.where("LOWER(name) LIKE :term OR LOWER(description) LIKE :term OR species_category IN (:categories)", 
              term: "%#{search_term}%", categories: category_terms)
        .where.not(seller_id: current_user.id)
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
