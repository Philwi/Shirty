module Shirty
  module Entities
    module Images
      class Product < ActiveRecord::Base
        self.table_name = 'printify_images'
      end
    end
  end
end
