module Shirty
  module Entities
    module Printify
      class Variant < ActiveRecord::Base
        self.table_name = 'printify_variants'

        serialize :variants, Array

        belongs_to :printify_print_provider, class_name: 'Printify::PrintProvider'
        belongs_to :printify_blueprint, class_name: 'Printify::Blueprint'
      end
    end
  end
end
