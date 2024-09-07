FactoryBot.define do
  factory :auction do
    association :item
    association :seller, factory: :user
    start_date { Date.current + rand(0..14).days } # Randomly selects a start date from now to 14 days in the future
    end_date { start_date + rand(7..14).days } # Sets end date to 7 to 14 days after the start date
    starting_price { rand(50.0..200.0).round(2) } # Random starting price between 50 and 200
    buy_it_now_price { starting_price + rand(50.0..100.0).round(2) } # Random buy it now price higher than starting price
    bid_increment { rand(5.0..20.0).round(2) } # Random bid increment between 5 and 20
    status { :listed }
    reserve_price { [true, false].sample ? starting_price + rand(30.0..70.0).round(2) : nil } # Randomly set reserve price or nil
    enable_buy_it_now { [true, false].sample } # Randomly true or false
    enable_reserve_price { reserve_price.present? } # True if reserve price is set
  end
end
