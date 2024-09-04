FactoryBot.define do
  factory :item do
    association :seller, factory: :user
    name { Faker::Commerce.product_name }
    description { Faker::Lorem.paragraph }
    category_type { Item.category_types.keys.sample }

    # Set default values for optional attributes to nil
    material { nil }
    shape { nil }
    color { nil }
    origin { nil }
    size { nil }
    essential_type { nil }
    wire_type { nil }
    species { nil }
    style { nil }
    stage { nil }
    tool_type { nil }

    material_other { nil }
    shape_other { nil }
    color_other { nil }
    origin_other { nil }
    essential_other { nil }
    wire_other { nil }
    species_other { nil }
    style_other { nil }
    size_other { nil }
    tool_other { nil }

    # Custom logic for setting attributes based on category_type
    after(:build) do |item|
      case item.category_type
      when 'plant'
        item.species ||= Item.species.keys.sample
        item.style ||= Item.styles.keys.sample
        item.stage ||= Item.stages.keys.sample

        # Add validation for required container fields for plants
        item.material ||= Item.materials.keys.sample
        item.shape ||= Item.shapes.keys.sample
        item.color ||= Item.colors.keys.sample
        item.origin ||= Item.origins.keys.sample
        item.size ||= Item.sizes.keys.sample

      when 'container'
        item.material ||= Item.materials.keys.sample
        item.shape ||= Item.shapes.keys.sample
        item.color ||= Item.colors.keys.sample
        item.origin ||= Item.origins.keys.sample
        item.size ||= Item.sizes.keys.sample

      when 'essential'
        item.essential_type ||= Item.essential_types.keys.sample
        if item.essential_type == 'wire'
          item.wire_type ||= Item.wire_types.keys.sample
        elsif item.essential_type == 'tools'
          item.tool_type ||= Item.tool_types.keys.sample
        end
      end

      # Conditionally set "other" fields based on their main attributes
      item.material_other = "Custom material" if item.material == 'material_other'
      item.shape_other = "Custom shape" if item.shape == 'shape_other'
      item.color_other = "Custom color" if item.color == 'color_other'
      item.origin_other = "Custom origin" if item.origin == 'origin_other'
      item.essential_other = "Custom essential" if item.essential_type == 'essential_other'
      item.wire_other = "Custom wire" if item.wire_type == 'wire_other'
      item.species_other = "Custom species" if item.species == 'species_other'
      item.style_other = "Custom style" if item.style == 'style_other'
      item.size_other = "Custom size" if item.size == 'size_other'
      item.tool_other = "Custom tool" if item.tool_type == 'tool_other'
    end
  end
end
