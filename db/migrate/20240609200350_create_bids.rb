class CreateBids < ActiveRecord::Migration[7.1]
  def change
    create_table :bids do |t|
      t.references :bidder, null: false, foreign_key: { to_table: :users }
      t.references :auction, null: false, foreign_key: true
      t.float :bid_amount

      t.timestamps
    end

    add_index :bids, :auction_id unless index_exists?(:bids, :auction_id)
    add_index :bids, :bidder_id unless index_exists?(:bids, :bidder_id)
  end
end
