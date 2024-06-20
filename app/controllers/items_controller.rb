class ItemsController < ApplicationController
  require 'mini_magick'
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
    @item.seller = current_user
  
    # Ensure auction is built and seller_id is set
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
      if @item.update(update_params)
        @item.auction.update(seller: current_user) if @item.auction.seller.nil?
        @item.auction.set_auction_times # Move the logic to model
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

  def set_item
    @item = Item.find(params[:id])
  end

  def item_params
    params.require(:item).permit(
      :name, :description, :category_type, :species, :style, :stage, :material, :shape, :color, :size, :origin, :essential_type,
      :species_other, :style_other, :shape_other, :color_other, :origin_other, :essential_other, :wire_other, :tool_other, :brand, :condition, :wire_type, :tool_type, :material_other, :size_other, images: [],
      auction_attributes: [
        :starting_price, :bid_increment, :buy_it_now_price, :timing_option, 
        :auction_length, :start_date, :start_time, :end_time
      ]
    ).tap do |whitelisted|
      integer_fields = [:category_type, :species, :style, :stage, :material, :shape, :color, :size, :origin, :essential_type, :wire_type, :tool_type]
      integer_fields.each do |field|
        whitelisted[field] = Item.send(field.to_s.pluralize)[whitelisted[field]] if whitelisted[field].present?
      end
    end
  end

  def update_params
    item_attributes = item_params
    auction_attributes = item_params[:auction_attributes]

    if auction_attributes
      @item.auction.assign_attributes(auction_attributes)
      @item.auction.seller = current_user if @item.auction.seller.nil?
    end

    item_attributes
  end
  
  def attach_images
    params[:item][:images].each do |file|
      next if file.blank? || file.is_a?(String)  # Skip empty or invalid files

      unless @item.images.any? { |img| img.filename.to_s == file.original_filename }
        compressed_file = compress_image(file)
        if compressed_file
          @item.images.attach(io: compressed_file[:io], filename: compressed_file[:filename], content_type: compressed_file[:content_type])
        end
      end
    end
  end

  def compress_image(file)
    begin
      if file.is_a?(ActionDispatch::Http::UploadedFile)
        tempfile = file.tempfile
      elsif file.is_a?(ActiveStorage::Blob)
        tempfile = file.download_blob_to_tempfile
      else
        Rails.logger.error "Invalid file type: #{file.class.name}"
        return nil
      end
  
      image = MiniMagick::Image.read(tempfile)
      Rails.logger.info "Image format: #{image.type}"
      image.resize "1200x1200"
      image.quality 80
  
      compressed_tempfile = Tempfile.new(["compressed", ".jpg"])
      image.write(compressed_tempfile.path)
  
      { io: compressed_tempfile, filename: file.original_filename, content_type: file.content_type }
    ensure
      tempfile.close if tempfile && !tempfile.closed?
      compressed_tempfile.close if compressed_tempfile && !compressed_tempfile.closed?
    end
  end

  def remove_images
    if params[:item][:remove_images].present?
      params[:item][:remove_images].each do |signed_id|
        begin
          image = ActiveStorage::Blob.find_signed(signed_id)
          if image
            image.attachments.each(&:purge_later)
          else
            Rails.logger.warn "Image with signed_id #{signed_id} not found"
          end
        rescue ActiveSupport::MessageVerifier::InvalidSignature => e
          Rails.logger.warn "Invalid signature for signed_id #{signed_id}: #{e.message}"
        end
      end
    end
  end
end
