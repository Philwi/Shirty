module Shirty
  module Repositories
    module Printify
      class Variants
        def all
          variant_entity.all
        end

        def find_by_printify_id(printify_id:)
          variant_entity.find_by(printify_id:)
        end

        def find_by(blueprint_id:, print_provider_id:)
          variant_entity.find_by(blueprint_id:, print_provider_id:)
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

        def delete_all_variants
          variant_entity.destroy_all
        end

        private

        def variant_entity
          Shirty::Entities::Printify::Variant
        end
      end
    end
  end
end
