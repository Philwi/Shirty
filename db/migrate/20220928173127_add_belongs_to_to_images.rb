class AddBelongsToToImages < ActiveRecord::Migration[7.0]
  def change
    add_belongs_to :printify_images, :image, index: true
  end
end
