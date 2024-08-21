class AddEnableBuyItNowAndEnableReservePriceToAuctions < ActiveRecord::Migration[7.1]
  def change
    add_column :auctions, :enable_buy_it_now, :boolean
    add_column :auctions, :enable_reserve_price, :boolean
  end
end
