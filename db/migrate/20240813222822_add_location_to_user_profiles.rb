class AddLocationToUserProfiles < ActiveRecord::Migration[7.1]
  def change
    add_column :user_profiles, :location, :string
  end
end
