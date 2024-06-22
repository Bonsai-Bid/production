class AddTimeZoneToUserProfiles < ActiveRecord::Migration[7.1]
  def change
    add_column :user_profiles, :time_zone, :string
  end
end
