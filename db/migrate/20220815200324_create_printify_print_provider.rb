class CreatePrintifyPrintProvider < ActiveRecord::Migration[7.0]
  def change
    create_table :printify_print_providers do |t|
      t.integer :printify_id
      t.string :title
      t.string :location
      t.belongs_to :printify_blueprint, index: true
    end
  end
end
