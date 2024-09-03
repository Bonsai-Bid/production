FactoryBot.define do
  factory :rating do
    user_profile
    rating_type { %w[positive neutral negative].sample }
    rating_value { Faker::Number.between(from: 1.0, to: 5.0) }
  end
end