module Shirty
  module Http
    class Printify
      class Blueprints
        RESOURCE = 'catalog/blueprints.json'.freeze

        def all
          Shirty::Http::Printify.new(RESOURCE).index
        end
      end
    end
  end
end
