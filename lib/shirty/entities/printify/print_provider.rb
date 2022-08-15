module Shirty
  module Entities
    module Printify
      class PrintProvider < ActiveRecord::Base
        self.table_name = 'printify_print_providers'

        belongs_to :blueprint, class_name: 'Shirty::Entities::Printify::Blueprint'
      end
    end
  end
end
