class AddSellerPolicyToUserProfiles < ActiveRecord::Migration[7.1]
  def change
    add_column :user_profiles, :seller_policy, :text
  end
end
