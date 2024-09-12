# spec/support/feature_helper.rb

module FeatureHelper
  def sign_in(user)
    login_as(user, scope: :user)
  end
end
