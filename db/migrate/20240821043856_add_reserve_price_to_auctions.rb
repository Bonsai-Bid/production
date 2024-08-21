class AddReservePriceToAuctions < ActiveRecord::Migration[7.1]
  def change
    add_column :auctions, :reserve_price, :float
  end
end
