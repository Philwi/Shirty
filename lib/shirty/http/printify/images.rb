module Shirty
  module Http
    class Printify
      class Images
        RESOURCE = 'uploads/images.json'.freeze

        def create(attributes)
          Shirty::Http::Printify.new(RESOURCE).create(body: attributes)
        end

        def all
          Shirty::Http::Printify.new(RESOURCE).index
        end
      end
    end
  end
end
