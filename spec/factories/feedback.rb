FactoryBot.define do

  factory :feedback do
    association :from_user, factory: :user
    association :to_user, factory: :user
    sale_transaction
    auction
    rating { Faker::Number.between(from: 1, to: 5) }
    comment { Faker::Lorem.sentence }
    reply { Faker::Lorem.sentence }
  end
end