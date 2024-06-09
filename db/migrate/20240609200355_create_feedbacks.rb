class CreateFeedbacks < ActiveRecord::Migration[7.1]
  def change
    create_table :feedbacks do |t|
      t.references :from_user, null: false, foreign_key: { to_table: :users }
      t.references :to_user, null: false, foreign_key: { to_table: :users }
      t.references :sale_transaction, null: false, foreign_key: true
      t.references :auction, null: false, foreign_key: true
      t.integer :rating
      t.text :comment
      t.text :reply

      t.timestamps
    end

    add_index :feedbacks, :from_user_id unless index_exists?(:feedbacks, :from_user_id)
    add_index :feedbacks, :to_user_id unless index_exists?(:feedbacks, :to_user_id)
    add_index :feedbacks, :sale_transaction_id unless index_exists?(:feedbacks, :sale_transaction_id)
    add_index :feedbacks, :auction_id unless index_exists?(:feedbacks, :auction_id)
  end
end
