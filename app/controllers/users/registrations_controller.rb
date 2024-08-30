class Users::RegistrationsController < Devise::RegistrationsController
  before_action :configure_permitted_parameters, if: :devise_controller?

  def create
    build_resource(sign_up_params)

    # Attempt to save the resource (user)
    if resource.save
      yield resource if block_given?
      if resource.active_for_authentication?
        set_flash_message! :notice, :signed_up
        sign_up(resource_name, resource)
        redirect_to dashboard_user_path(resource) and return
      else
        set_flash_message! :notice, :"signed_up_but_#{resource.inactive_message}"
        expire_data_after_sign_in!
        redirect_to after_inactive_sign_up_path_for(resource) and return
      end
    else
      # Handles validation failures, including custom validations (XSS, SQL checks)
      clean_up_passwords resource
      set_minimum_password_length
      flash[:alert] = resource.errors.full_messages.join(", ")
      respond_with resource
    end
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [
      :first_name, :last_name, :phone, :street, :city, :state, :zip, :time_zone
    ])
    devise_parameter_sanitizer.permit(:account_update, keys: [
      :first_name, :last_name, :phone, :street, :city, :state, :zip, :time_zone
    ])
  end
end
