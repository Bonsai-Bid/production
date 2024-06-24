class RemoveImagesFromItems < ActiveRecord::Migration[7.1]
  def change
    remove_column :items, :images, :text
  end
end
