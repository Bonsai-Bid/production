FactoryBot.define do
  factory :reply do
    content { Faker::Lorem.sentence }
    association :user
    respondable { association :feedback } # Can be associated with other models like Inquiry as well
  end
end