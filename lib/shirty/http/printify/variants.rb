module Shirty
  module Http
    class Printify
      class Variants
        RESOURCE_PREFIX = 'catalog/blueprints'.freeze
        RESOURCE = 'variants.json'.freeze

        def all_for_blueprint_and_print_provider(blueprint:, print_provider:)
          Shirty::Http::Printify.new(
            resource_for_blueprint_and_print_provider(
              blueprint: blueprint,
              print_provider: print_provider
            )
          ).index
        end

        private

        def resource_for_blueprint_and_print_provider(blueprint:, print_provider:)
          "#{RESOURCE_PREFIX}/#{blueprint.printify_id}/print_providers/#{print_provider.printify_id}/#{RESOURCE}"
        end
      end
    end
  end
end
