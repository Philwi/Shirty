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
            images: blueprint_attributes['images'],
            description: blueprint_attributes['description']
          )
        end

        private

        def blueprint_entity
          ::Shirty::Entities::Printify::Blueprint
        end
      end
    end
  end
end
