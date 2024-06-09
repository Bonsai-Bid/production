class CreateAuctions < ActiveRecord::Migration[7.1]
  def change
    create_table :auctions do |t|
      t.references :item, null: false, foreign_key: true
      t.references :seller, null: false, foreign_key: { to_table: :users }
      t.datetime :start_date
      t.datetime :end_date
      t.float :starting_price
      t.float :buy_it_now_price
      t.float :bid_increment
      t.integer :status

      t.timestamps
    end

    add_index :auctions, :item_id unless index_exists?(:auctions, :item_id)
    add_index :auctions, :seller_id unless index_exists?(:auctions, :seller_id)
  end
end
