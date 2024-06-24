class WatchlistsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_watchlist, only: %i[show edit update destroy]

  def index
    @watchlists = current_user.watchlists.includes(:auction).map(&:auction)
  end

  def show
  end

  def new
  end

  def edit
  end

  def create
    @auction = Auction.find(params[:auction_id])
    @watchlist = current_user.watchlists.build(auction: @auction)

    respond_to do |format|
      if @watchlist.save
        format.html { redirect_to auction_path(@auction), notice: "Item successfully added to your watchlist" }
        format.json { render :show, status: :created, location: @watchlist }
      else
        format.html { redirect_to auction_path(@auction), alert: "Unable to add auction to watchlist" }
        format.json { render json: @watchlist.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @watchlist.update(watchlist_params)
        format.html { redirect_to watchlist_url(@watchlist), notice: "Watchlist was successfully updated." }
        format.json { render :show, status: :ok, location: @watchlist }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @watchlist.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @watchlist.destroy
    respond_to do |format|
      format.html { redirect_to dashboard_user_path(current_user), notice: "Watchlist was successfully removed." }
      format.json { head :no_content }
    end
  end

  private

  def set_watchlist
    @watchlist = current_user.watchlists.find(params[:id])
  end

  def watchlist_params
    params.require(:watchlist).permit(:auction_id)
  end
end
