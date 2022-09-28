module Shirty
  module Entities
    module Printify
      class Product < ActiveRecord::Base
        self.table_name = 'printify_products'

        belongs_to :printify_image
      end
    end
  end
end
