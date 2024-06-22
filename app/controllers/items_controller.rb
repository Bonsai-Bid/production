class ItemsController < ApplicationController
  before_action :set_item, only: %i[show edit update destroy]

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
    Rails.logger.debug "Raw params: #{params.inspect}"
    @item = Item.new(item_params)
    @item.seller = current_user
    if @item.auction
      @item.auction.seller_id = current_user.id
      @item.auction.set_auction_times
    else
      @item.build_auction(seller_id: current_user.id)
    end

    respond_to do |format|
      if @item.save
        attach_images if params[:item][:images].present?
        format.html { redirect_to dashboard_user_path(current_user), notice: "Item and associated auction were successfully created." }
        format.json { render :show, status: :created, location: @item }
      else
        logger.debug @item.errors.full_messages
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
      if @item.update(item_params.except(:remove_images))
        @item.auction.update(seller: current_user) if @item.auction.seller.nil?
        @item.auction.set_auction_times
        attach_images if params[:item][:images].present?
        remove_images if params[:item][:remove_images].present?
        format.html { redirect_to auction_path(@item.auction), notice: "Item was successfully updated." }
        format.json { render :show, status: :ok, location: @item }
      else
        logger.debug @item.errors.full_messages
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

  def item_params
    params.require(:item).permit(
      :name, :description, :category_type, :species, :style, :stage, :material, :shape, :color, :size, :origin, :essential_type,
      :species_other, :style_other, :shape_other, :color_other, :origin_other, :essential_other, :wire_other, :tool_other, :brand, :condition, :wire_type, :tool_type, :material_other, :size_other, images: [], remove_images: [],
      auction_attributes: [
        :starting_price, :bid_increment, :buy_it_now_price, :timing_option,
        :auction_length, :start_date, :start_time, :end_time, :id
      ]
    )
  end

  def set_item
    @item = Item.find(params[:id])
  end

  def attach_images
    return unless params[:item][:images].present?

    params[:item][:images].each do |image|
      next if image.blank?

      compressed_image = compress_image(image)
      @item.images.attach(compressed_image)
    end
  end

  def compress_image(image)
    compressed_tempfile = ImageProcessing::MiniMagick
      .source(image)
      .resize_to_limit(1200, 1200)
      .convert("jpg")
      .saver(quality: 80)
      .call

    { io: File.open(compressed_tempfile.path), filename: image.original_filename, content_type: 'image/jpeg' }
  ensure
    compressed_tempfile.close if compressed_tempfile
    compressed_tempfile.unlink if compressed_tempfile
  end

  def remove_images
    return unless params[:item][:remove_images].present?

    params[:item][:remove_images].each do |signed_id|
      image = ActiveStorage::Blob.find_signed(signed_id)
      image.attachments.each(&:purge_later)
    end
  end
end
