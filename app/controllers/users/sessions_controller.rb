class Users::SessionsController < Devise::SessionsController
  protected

  def after_sign_out_path_for(resource_or_scope)
    root_path
    # new_user_session_path # Typically the login path
  end
end
