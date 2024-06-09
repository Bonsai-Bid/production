class Watchlist < ApplicationRecord
  belongs_to :user
  belongs_to :auction
  
  validates :auction_id, uniqueness: { scope: :user_id, message: "has already been added to your watchlist" }


  # def seller_name
  #   user = User.find(self.user_id)
  #   user.name
  # end

  # def item_name
  #   item = Item.find(self.item_id)
  #   item.name
  # end



end
