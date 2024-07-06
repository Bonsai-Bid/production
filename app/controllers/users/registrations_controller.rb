class Users::RegistrationsController < Devise::RegistrationsController
  before_action :configure_permitted_parameters, if: :devise_controller?

  

  def edit
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:street, :city, :state, :zip, user_profile_attributes: [:name, :phone, :time_zone]])
    devise_parameter_sanitizer.permit(:account_update, keys: [:street, :city, :state, :zip, user_profile_attributes: [:name, :phone, :time_zone]])
  end
end
