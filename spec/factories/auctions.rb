FactoryBot.define do

  factory :auction do
    association :item
    association :seller, factory: :user
    start_date { Time.current }
    end_date { Time.current + 7.days }
    starting_price { 100.0 }
    buy_it_now_price { 200.0 }
    bid_increment { 10.0 }
    status { 1 } # Assuming 1 is a valid status
    reserve_price { 150.0 }
    enable_buy_it_now { true }
    enable_reserve_price { true }
  end
end