class CreateItems < ActiveRecord::Migration[7.1]
  def change
    create_table :items do |t|
      t.references :seller, null: false, foreign_key: { to_table: :users }
      t.string :name
      t.text :description
      t.text :images
      t.integer :category_type
      t.integer :material
      t.integer :shape
      t.integer :color
      t.integer :origin
      t.integer :essential_type
      t.integer :wire_type
      t.integer :species
      t.integer :style
      t.integer :stage
      t.integer :tool_type
      t.string :material_other
      t.string :shape_other
      t.string :color_other
      t.string :origin_other
      t.string :essential_other
      t.string :wire_other
      t.string :species_other
      t.string :style_other
      t.integer :size
      t.string :size_other
      t.string :brand
      t.string :condition
      t.string :tool_other
      t.integer :species_category

      t.timestamps
    end

    add_index :items, :seller_id unless index_exists?(:items, :seller_id)  
  end
end
