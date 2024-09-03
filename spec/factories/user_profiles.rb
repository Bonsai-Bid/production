FactoryBot.define do
  factory :user_profile do
    user
    name { "#{user.first_name} #{user.last_name}" }
    about_me { Faker::Lorem.paragraph }
    seller_policy { Faker::Lorem.paragraph }
    location { Faker::Address.city }
  end
end