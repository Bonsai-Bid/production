class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :set_time_zone



  private

  def set_time_zone
    Time.zone = user_time_zone || default_time_zone
  end

  def user_time_zone
    current_user&.time_zone
  end

  def default_time_zone
    'Pacific Time (US & Canada)' # Set Pacific Time as the default
  end
end
