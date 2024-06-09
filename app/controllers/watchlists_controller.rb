class WatchlistsController < ApplicationController
  before_action :set_watchlist, only: %i[ show edit update destroy ]

  def index
    @watchlists = current_user.watchlists
  end

  def show
  end

  def new
    # @watchlist = Watchlist.new
  end


  def edit
  end


  def create
    @watchlist = current_user.watchlists.build(watchlist_params)
    respond_to do |format|
      if @watchlist.save 
        format.html { redirect_to dashboard_user_path(current_user.id), notice: "Item successfully added to your watchlist" }
        format.json { render :show, status: :created, location: @watchlist }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @watchlist.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /watchlists/1 or /watchlists/1.json
  def update
    # respond_to do |format|
    #   if @watchlist.update(watchlist_params)
    #     format.html { redirect_to watchlist_url(@watchlist), notice: "Watchlist was successfully updated." }
    #     format.json { render :show, status: :ok, location: @watchlist }
    #   else
    #     format.html { render :edit, status: :unprocessable_entity }
    #     format.json { render json: @watchlist.errors, status: :unprocessable_entity }
    #   end
    # end
  end

  # DELETE /watchlists/1 or /watchlists/1.json
  def destroy
    @watchlist.destroy!

    respond_to do |format|
      format.html { redirect_to dashboard_user_path(current_user.id), notice: "Watchlist was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private

  def set_watchlist
    @watchlist = Watchlist.find(params[:id])
  end

  def watchlist_params
    auction_id = params.dig(:watchlist, :auction_id) || params[:auction_id]
    { auction_id: auction_id, user_id: current_user.id }
  end
end
