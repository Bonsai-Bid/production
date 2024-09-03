FactoryBot.define do

  factory :item do
    association :seller, factory: :user
    name { Faker::Commerce.product_name }
    description { Faker::Lorem.paragraph }
    category_type { 1 } # Adjust based on valid enums
    material { 1 }
    shape { 1 }
    color { 1 }
    origin { 1 }
    essential_type { 1 }
    wire_type { 1 }
    species { 1 }
    style { 1 }
    stage { 1 }
    tool_type { 1 }
    material_other { nil }
    shape_other { nil }
    color_other { nil }
    origin_other { nil }
    essential_other { nil }
    wire_other { nil }
    species_other { nil }
    style_other { nil }
    size { 1 }
    size_other { nil }
    brand { Faker::Company.name }
    condition { 'New' }
    tool_other { nil }
    species_category { 1 }
  end
end