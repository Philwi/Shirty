class AddVariantsToVariant < ActiveRecord::Migration[7.0]
  def change
    add_column :printify_variants, :variants, :text
  end
end
