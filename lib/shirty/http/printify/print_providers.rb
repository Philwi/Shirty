module Shirty
  module Http
    class Printify
      class PrintProviders
        RESOURCE_PREFIX = 'catalog/blueprints'.freeze
        RESOURCE = 'print_providers.json'.freeze

        def all_for_blueprint(blueprint)
          Shirty::Http::Printify.new(resource_for_blueprint(blueprint)).index
        end

        private

        def resource_for_blueprint(blueprint)
          "#{RESOURCE_PREFIX}/#{blueprint.printify_id}/#{RESOURCE}"
        end
      end
    end
  end
end
