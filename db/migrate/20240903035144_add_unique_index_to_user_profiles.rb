class AddUniqueIndexToUserProfiles < ActiveRecord::Migration[7.1]
  def change
    # Remove the existing index if it exists
    remove_index :user_profiles, :user_id if index_exists?(:user_profiles, :user_id)

    # Add a unique index on user_id
    add_index :user_profiles, :user_id, unique: true, name: 'index_user_profiles_on_user_id'
  end
end
