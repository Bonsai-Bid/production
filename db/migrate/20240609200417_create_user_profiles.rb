class CreateUserProfiles < ActiveRecord::Migration[7.1]
  def change
    create_table :user_profiles do |t|
      t.references :user, null: false, foreign_key: true
      t.string :name
      t.string :phone

      t.timestamps
    end

    add_index :user_profiles, :user_id unless index_exists?(:user_profiles, :user_id)
  end
end
