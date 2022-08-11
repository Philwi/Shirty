class AddFileToImage < ActiveRecord::Migration[7.0]
  def change
    add_column :images, :image_data, :text
  end
end
