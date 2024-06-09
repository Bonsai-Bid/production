class ItemsController < ApplicationController
  before_action :set_item, only: %i[ show edit update destroy ]

  def index
    @items = Item.all
  end

  def show
    @inquiry = Inquiry.new
  end

  def new
    if current_user.nil?
      flash[:alert] = "You must be logged in."
      redirect_to new_user_session_path
    else
      @item = Item.new
      @item.build_auction
    end
  end

  def create
    @item = Item.new(item_params)
    @item.auction.seller_id = current_user.id
    @item.seller = current_user

    respond_to do |format|
      if @item.save
        @item.auction.update(item_id: @item.id)
        format.html { redirect_to dashboard_user_path(current_user), notice: "Item and associated auction were successfully created." }
        format.json { render :show, status: :created, location: @item }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @item.errors, status: :unprocessable_entity }
      end
    end
  end

  def edit
    @item = Item.find(params[:id])
  end
  
  def update
    respond_to do |format|
      if @item.update(update_params)
        format.html { redirect_to auction_path(@item.auction), notice: "Item was successfully updated." }
        format.json { render :show, status: :ok, location: @item }
      else
        require 'pry'; binding.pry
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @item.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @item.destroy
    respond_to do |format|
      format.html { redirect_to dashboard_user_path(current_user), notice: "Item was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private

  def set_item
    @item = Item.find(params[:id])
  end

  def item_params
    params.require(:item).permit(
      :name, :description, :category_type, :species, :style, :stage, :material, :shape, :color, :size, :origin, :essential_type,
      :species_other, :style_other, :type_other, :shape_other, :color_other, :origin_other, :essential_other, :wire_other, :tool_other, :brand, :condition, :wire_type,
      auction_attributes: [:starting_price, :bid_increment, :start_date, :end_date, :buy_it_now_price, :status]
    ).tap do |whitelisted|
      integer_fields = [:category_type, :species, :style, :stage, :material, :shape, :color, :size, :origin, :essential_type, :wire_type, :tool_type]
      integer_fields.each do |field|
        whitelisted[field] = whitelisted[field].to_i if whitelisted[field].present?
      end
    end
  end

  def update_params
    item_attributes = item_params.except(:auction_attributes)
    auction_attributes = item_params[:auction_attributes]

    if auction_attributes
      @item.auction.assign_attributes(auction_attributes)
      @item.auction.seller = current_user if @item.auction.seller.nil?
    end

    item_attributes
  end
end
