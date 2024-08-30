class AddMaximumToUsers < ActiveRecord::Migration[7.1]
  def change
    change_column :users, :first_name, :string, limit: 50
    change_column :users, :last_name, :string, limit: 50
    change_column :users, :email, :string, limit: 255
    change_column :users, :phone, :string, limit: 15
    change_column :users, :street, :string, limit: 100
    change_column :users, :city, :string, limit: 50
    change_column :users, :zip, :string, limit: 10
  end
end
