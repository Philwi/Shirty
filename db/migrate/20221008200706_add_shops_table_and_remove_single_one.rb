class AddShopsTableAndRemoveSingleOne < ActiveRecord::Migration[7.0]
  def change
    drop_table :i_hate_everything_shops

    create_table :shops do |t|
      t.string :name
      t.string :prefix
      t.timestamps
    end
  end
end
