class RepliesController < ApplicationController
  before_action :set_parent_object
  before_action :set_reply, only: [:edit, :update, :destroy]

  # def index
  #   @replies = @parent.replies
  # end
  
  def new

    # @reply = @parent.replies.build
  end
  
  def create
    @reply = @parent.replies.build(reply_params)
    @reply.author = current_user # Assuming replies are associated with a user

    if @reply.save
      redirect_to return_path, notice: 'Reply was successfully created.'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @reply = @parent.replies.find(params[:id])


  end

  def update

    if @reply.update(reply_params)
      redirect_to return_path, notice: 'Reply was successfully updated.'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy

    @reply.destroy
    redirect_to return_path, notice: 'Reply was successfully deleted.'
  end

  private

  def set_parent_object
    @sale_transaction = SaleTransaction.find(params[:sale_transaction_id]) if params[:sale_transaction_id]
    if params[:feedback_id]
      @parent = Feedback.find(params[:feedback_id])
    elsif params[:inquiry_id]
      @parent = Inquiry.find(params[:inquiry_id])
    end
  end

  def set_reply
    @reply = @parent.replies.find(params[:id])
  end

  def reply_params
    params.require(:reply).permit(:content)
  end

  def return_path
    if @parent.is_a?(Feedback)
      if @sale_transaction
        sale_transaction_feedback_path(@sale_transaction, @parent)
      end
    else @parent.is_a?(Inquiry)
      auction_path(@parent.auction)
    end
  end
end
