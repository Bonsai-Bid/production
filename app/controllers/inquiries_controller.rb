class InquiriesController < ApplicationController
  before_action :authenticate_user!, only: [:create]
  before_action :set_auction, only: [:create]

  def create
    @inquiry = @auction.inquiries.new(inquiry_params)
    @inquiry.commenter = current_user
    @inquiry.seller_id = @auction.seller_id
    if @inquiry.save
      flash[:notice] = 'Inquiry posted successfully.'
      redirect_to auction_path(@auction)
    else
      set_auction
      flash.now[:alert] = "Comment can't be blank"
      render 'auctions/show', status: :unprocessable_entity
    end
  end



  def index
  end

  def show
  end

  private

  def set_auction
    @auction = Auction.find(params[:auction_id])
  end

  def inquiry_params
    params.require(:inquiry).permit(:comment)
  end
end
