module Shirty
  module Repositories
    module Printify
      class PrintProviders
        def all
          print_provider_entity.all
        end

        def create(print_provider_attributes:, blueprint:)
          print_provider_entity.create(
            printify_id: print_provider_attributes['id'],
            title: print_provider_attributes['title'],
            location: print_provider_attributes['location'],
            printify_blueprint_id: blueprint.id
          )
        end

        def find_by_printify_id_and_blueprint(printify_id:, blueprint:)
          print_provider_entity.find_by(printify_id: printify_id, printify_blueprint_id: blueprint.id)
        end

        def delete_all_providers
          print_provider_entity.destroy_all
        end

        private

        def print_provider_entity
          ::Shirty::Entities::Printify::PrintProvider
        end
      end
    end
  end
end
