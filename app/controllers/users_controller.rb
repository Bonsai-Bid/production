class UsersController < ApplicationController
  before_action :set_user, only: %i[ show edit update dashboard ]

  # def index
  #   @users = User.all
  # end

  def show
    @user = current_user
  end

  def dashboard
    if current_user != nil
      @watchlists = current_user.watchlist_auctions
    end
  end

  def profile
    if current_user.id != params[:id]
    @other_user = User.includes(sales: :feedbacks, purchases: :feedbacks).find(params[:id])
    # else
    #   redirect_to user_dashboard_path
    end
  end

  def edit
  end



  def update
    # respond_to do |format|
    #   if @user.update(user_params)
    #     format.html { redirect_to user_url(@user), notice: "User was successfully updated." }
    #     format.json { render :show, status: :ok, location: @user }
    #   else
    #     format.html { render :edit, status: :unprocessable_entity }
    #     format.json { render json: @user.errors, status: :unprocessable_entity }
    #   end
    # end
  end



  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = current_user if user_signed_in?
    end

    # Only allow a list of trusted parameters through.
    # def user_params
    #   params.require(:user).permit(:email, :password, :password_confirmation, :name, :street, :phone)
    # end
end
