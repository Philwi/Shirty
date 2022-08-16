class AddBelongsToToPrintuflVariants < ActiveRecord::Migration[7.0]
  def change
    add_belongs_to :printify_variants, :printify_print_provider, index: true
    add_belongs_to :printify_variants, :printify_blueprint, index: true
  end
end
