class HomeController < ApplicationController
  def index
    @user = current_user
    if current_user != nil
      @watchlists = @user.watchlist_auctions
    end
    @newest_auctions = Auction.newest_active.limit(10)
  end
end
