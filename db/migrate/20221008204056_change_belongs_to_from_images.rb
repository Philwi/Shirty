class ChangeBelongsToFromImages < ActiveRecord::Migration[7.0]
  def change
    remove_belongs_to :images, :shops

    add_belongs_to :images, :shop, index: true
  end
end
