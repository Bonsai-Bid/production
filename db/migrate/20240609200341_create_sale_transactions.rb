class CreateSaleTransactions < ActiveRecord::Migration[7.1]
  def change
    create_table :sale_transactions do |t|
      t.references :buyer, foreign_key: { to_table: :users }
      t.references :seller, foreign_key: { to_table: :users }
      t.float :final_price
      t.integer :payment_status
      t.references :auction, null: false, foreign_key: true

      t.timestamps
    end

    add_index :sale_transactions, :auction_id unless index_exists?(:sale_transactions, :auction_id)
  end
end
