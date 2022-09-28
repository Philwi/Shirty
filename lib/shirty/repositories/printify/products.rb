module Shirty
  module Repositories
    module Printify
      class Products
        def all
          product_entity.all
        end

        def create(product_attributes)
          product_entity.create(product_attributes)
        end

        private

        def product_entity
          ::Shirty::Entities::Printify::Product
        end
      end
    end
  end
end
