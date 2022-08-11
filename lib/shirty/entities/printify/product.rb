module Shirty
  module Entities
    module Printify
      class Product < ActiveRecord::Base
        self.table_name = 'printify_products'
      end
    end
  end
end
