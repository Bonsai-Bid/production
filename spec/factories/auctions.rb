FactoryBot.define do
  factory :auction do
    association :item
    association :seller, factory: :user
    start_date { DateTime.current + rand(0..14).days } 
    end_date { start_date + rand(7..14).days } 
    starting_price { rand(50.0..200.0).round(2) } 
    buy_it_now_price { starting_price + rand(50.0..100.0).round(2) } 
    bid_increment { rand(5.0..20.0).round(2) } 
    status { :listed }
    reserve_price { [true, false].sample ? starting_price + rand(30.0..70.0).round(2) : nil } 
    enable_buy_it_now { [true, false].sample }
    enable_reserve_price { reserve_price.present? } 
    
  end
end
