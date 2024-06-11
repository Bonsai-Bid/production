# app/controllers/bids_controller.rb
class BidsController < ApplicationController
  before_action :authenticate_user!

  def create
    @auction = Auction.find(params[:auction_id])
    @bid = @auction.bids.build(bid_params)
    @bid.bidder = current_user

    if @bid.save
      redirect_to @auction, notice: 'Bid was successfully placed.'
    else
      redirect_to @auction, alert: 'There was an error placing your bid.'
    end
  end

  private

  def bid_params
    params.require(:bid).permit(:bid_amount)
  end
end
