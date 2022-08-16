module Shirty
  module Repositories
    module Printify
      class Variants
        def find_by_printify_id(printify_id:)
          variant_entity.find_by(printify_id: printify_id)
        end

        def create(variant_attributes:, blueprint:, print_provider:)
          variant_entity.create(
            printify_id: variant_attributes['id'].to_i,
            title: variant_attributes['title'],
            placeholders: variant_attributes['placeholders'],
            options: variant_attributes['options'],
            variants: variant_attributes['variants'],
            printify_blueprint: blueprint,
            printify_print_provider: print_provider
          )
        end

        private

        def variant_entity
          Shirty::Entities::Printify::Variant
        end
      end
    end
  end
end
