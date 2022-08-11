class CreatePrintifyImage < ActiveRecord::Migration[7.0]
  def change
    create_table :printify_images do |t|
      t.string :printify_id
      t.string :file_name
      t.integer :height
      t.integer :width
      t.integer :size
      t.string :mime_type
      t.datetime :upload_time
    end
  end
end
