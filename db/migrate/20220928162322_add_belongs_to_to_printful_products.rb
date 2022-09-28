class AddBelongsToToPrintfulProducts < ActiveRecord::Migration[7.0]
  def change
    add_belongs_to :printify_products, :printify_images, index: true
  end
end
