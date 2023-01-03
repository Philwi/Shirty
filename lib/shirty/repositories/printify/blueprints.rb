module Shirty
  module Repositories
    module Printify
      class Blueprints
        def all
          blueprint_entity.all
        end

        def create(blueprint_attributes)
          blueprint_entity.create(
            printify_id: blueprint_attributes['id'],
            title: blueprint_attributes['title'],
            brand: blueprint_attributes['brand'],
            model: blueprint_attributes['model'],
            images: parsed_images_array(blueprint_attributes['images']),
            description: blueprint_attributes['description']
          )
        end

        def find_by_printify_id(printify_id:)
          blueprint_entity.find_by(printify_id:)
        end

        private

        def blueprint_entity
          ::Shirty::Entities::Printify::Blueprint
        end

        def parsed_images_array(images)
          return images if images.is_a?(Array)

          images.map { |_, image| image } if images.is_a?(Hash)

          []
        end
      end
    end
  end
end
