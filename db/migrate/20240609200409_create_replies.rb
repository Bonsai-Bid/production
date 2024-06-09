class CreateReplies < ActiveRecord::Migration[7.1]
  def change
    create_table :replies do |t|
      t.text :content
      t.references :user, null: false, foreign_key: true
      t.references :respondable, polymorphic: true

      t.timestamps
    end

    add_index :replies, :user_id unless index_exists?(:replies, :user_id)
  end
end
