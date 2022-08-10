module Shirtie
  module Http
    module Printify
      module Products
        RESOURCE = 'products'.freeze

        class << self
          def create(attributes)
            Shirtie::Http::Printify.new(RESOURCE).create(params: attributes)
          end
        end
      end
    end
  end
end
