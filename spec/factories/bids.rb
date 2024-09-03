FactoryBot.define do

  factory :bid do
    association :bidder, factory: :user
    auction
    bid_amount { Faker::Number.between(from: 100.0, to: 500.0) }
  end
end