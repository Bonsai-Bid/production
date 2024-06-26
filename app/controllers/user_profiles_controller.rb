# app/controllers/user_profiles_controller.rb
class UserProfilesController < ApplicationController
  before_action :set_user_profile, only: [:show, :edit, :update]

  def show
    @user = @user_profile.user
  end

  def edit
  end

  def update
    if @user_profile.update(user_profile_params)
      attach_images
      redirect_to @user_profile, notice: 'Profile was successfully updated.'
    else
      render :edit
    end
  end

  private

  def set_user_profile
    @user_profile = UserProfile.find(params[:id])
  end

  def user_profile_params
    params.require(:user_profile).permit(:name, :about_me, :profile_picture, :banner_image, :seller_policy, :time_zone)
  end

  def attach_images
    attach_image(:profile_picture)
    attach_image(:banner_image)
  end

  def attach_image(image_type)
    return unless params[:user_profile][image_type].present?

    @user_profile.send(image_type).purge
    compressed_image = compress_image(params[:user_profile][image_type])
    @user_profile.send(image_type).attach(compressed_image)
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
end
