FactoryBot.define do
  factory :inquiry do
    association :commenter, factory: :user
    association :seller, factory: :user
    comment { Faker::Lorem.sentence }
    parent_id { nil } # Adjust as needed for nested inquiries
    auction
  end
end