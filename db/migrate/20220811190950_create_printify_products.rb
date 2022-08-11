class CreatePrintifyProducts < ActiveRecord::Migration[7.0]
  def change
    create_table :printify_products do |t|
      t.string :prinfify_id
      t.string :title
      t.string :description
      t.string :tags, array: true, default: []
      t.string :options, array: true, default: []
      t.string :variants, array: true, default: []
      t.string :images, array: true, default: []
      t.string :printify_created_at
      t.string :printify_updated_at
      t.boolean :visible, default: true
      t.integer :blueprint_id
      t.integer :print_provider_id
      t.integer :user_id
      t.integer :shop_id
      t.string :print_areas, array: true, default: []
      t.string :print_details, array: true, default: []
      t.boolean :is_locked, default: true
      t.string :sales_channel_properties, array: true, default: []
    end
  end
end
