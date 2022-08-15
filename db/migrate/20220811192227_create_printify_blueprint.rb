class CreatePrintifyBlueprint < ActiveRecord::Migration[7.0]
  def change
    create_table :printify_blueprints do |t|
      t.integer :printify_id
      t.string :title
      t.string :description
      t.string :brand
      t.string :model
      t.string :images, array: true, default: []
    end
  end
end
