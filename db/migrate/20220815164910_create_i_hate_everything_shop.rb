class CreateIHateEverythingShop < ActiveRecord::Migration[7.0]
  def change
    create_table :i_hate_everything_shops do |t|
      t.belongs_to :word, index: true
      t.timestamps
    end
  end
end
