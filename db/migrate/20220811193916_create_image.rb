class CreateImage < ActiveRecord::Migration[7.0]
  def change
    create_table :images do |t|
      t.string :file_name
      t.integer :height
      t.integer :width
      t.integer :size
      t.string :mime_type
      t.timestamps
      t.belongs_to :words, index: true
    end
  end
end
