module Shirty
  module Http
    class Printify
      class Products
        RESOURCE = 'products'.freeze

        def create(attributes)
          Shirty::Http::Printify.new(RESOURCE).create(body: attributes)
        end
      end
    end
  end
end
