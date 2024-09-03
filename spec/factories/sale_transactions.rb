FactoryBot.define do
  factory :sale_transaction do
    association :buyer, factory: :user
    association :seller, factory: :user
    final_price { Faker::Number.between(from: 100.0, to: 1000.0) }
    payment_status { 1 } # Adjust based on valid enums
    auction
  end
end