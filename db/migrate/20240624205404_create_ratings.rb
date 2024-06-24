class CreateRatings < ActiveRecord::Migration[7.1]
  def change
    create_table :ratings do |t|
      t.references :user_profile, null: false, foreign_key: true
      t.string :rating_type, null: false
      t.float :rating_value, null: false

      t.timestamps
    end
  end
end
