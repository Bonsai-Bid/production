class CreateInquiries < ActiveRecord::Migration[7.1]
  def change
    create_table :inquiries do |t|
      t.references :commenter, foreign_key: { to_table: :users }
      t.references :seller, foreign_key: { to_table: :users }
      t.text :comment
      t.bigint :parent_id
      t.references :auction, foreign_key: true

      t.timestamps
    end
  end
end
