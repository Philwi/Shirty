class CreatePrintifyVariant < ActiveRecord::Migration[7.0]
  def change
    create_table :printify_variants do |t|
      t.integer :printify_id
      t.string :title
      t.text :options
      t.string :placeholders, array: true, default: []
    end
  end
end
