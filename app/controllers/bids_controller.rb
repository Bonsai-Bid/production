class BidsController < ApplicationController
  before_action :authenticate_user!

  def create
    @auction = Auction.find(params[:auction_id])
    @bid = @auction.bids.build(bid_params)
    @bid.bidder = current_user

    if @auction.active? && @bid.save
      redirect_to @auction, notice: 'Your bid was successfully placed.'
    else
      @auction.bids.reload # Ensure errors are populated for display
      flash.now[:alert] = 'Your bid could not be placed.'
      render 'auctions/show'
    end
  end

  def index
    @auction = Auction.find(params[:auction_id])
    @bids = @auction.bids  
  end
  private

  def bid_params
    params.require(:bid).permit(:bid_amount)
  end
end
