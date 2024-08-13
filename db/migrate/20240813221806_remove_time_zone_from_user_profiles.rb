class RemoveTimeZoneFromUserProfiles < ActiveRecord::Migration[7.1]
  def change
    remove_column :user_profiles, :time_zone, :string
  end
end
