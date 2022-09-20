module Shirty
  module Http
    class Printify
      class Images
        RESOURCE = 'uploads/images.json'.freeze

        def create(attributes)
          Shirty::Http::Printify.new(RESOURCE).create(body: attributes)
        end
      end
    end
  end
end
