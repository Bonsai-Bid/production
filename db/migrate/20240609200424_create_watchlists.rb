class CreateWatchlists < ActiveRecord::Migration[7.1]
  def change
    create_table :watchlists do |t|
      t.references :user, null: false, foreign_key: true
      t.references :auction, null: false, foreign_key: true

      t.timestamps
    end

    add_index :watchlists, :user_id unless index_exists?(:watchlists, :user_id)
    add_index :watchlists, :auction_id unless index_exists?(:watchlists, :auction_id)
  end
end
