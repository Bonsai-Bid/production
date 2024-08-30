# app/services/search_service.rb

class SearchService
  def self.search(query)
    item_results = Item.search(query).records.to_a
    auction_results = Auction.search(query).records.to_a
    item_results + auction_results
  end
end
