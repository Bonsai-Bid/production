class AuctionsController < ApplicationController
  before_action :authenticate_user! 

  before_action :set_auction, only: [:show, :bidding_history, :edit, :update, :destroy]

  def show
    @inquiry = Inquiry.new
    @bid = Bid.new if current_user && current_user.id != @auction.seller_id
  end

  def edit
  end

  def bidding_history
    @bids = @auction.bids.order(bid_amount: :desc)
  end

  def update
    respond_to do |format|
      if @auction.update(auction_params)
        format.html { redirect_to @auction, notice: 'Auction was successfully updated.' }
        format.json { render :show, status: :ok, location: @auction }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @auction.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @auction.destroy
    respond_to do |format|
      format.html { redirect_to items_url, notice: 'Auction was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  def set_auction
    @auction = Auction.find(params[:id])
  end

  def auction_params
    params.require(:auction).permit(:start_date, :end_date, :starting_price, :buy_it_now_price, :bid_increment, :status, item_attributes: [:name, :description, :category_type, :species, :style, :stage, :material, :shape, :color, :size, :origin, :essential_type, :species_other, :style_other, :type_other, :shape_other, :color_other, :origin_other, :essential_other, :wire_other, :tool_other, :brand, :condition, :wire_type])
  end
end