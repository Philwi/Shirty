module Shirty
  module Entities
    module Printify
      class Image < ActiveRecord::Base
        self.table_name = 'printify_images'

        belongs_to :images, class_name: 'Shirty::Entities::Image'
        has_many :printify_products
      end
    end
  end
end
