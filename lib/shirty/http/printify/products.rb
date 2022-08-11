module Shirty
  module Http
    module Printify
      module Products
        RESOURCE = 'products'.freeze

        class << self
          def create(attributes)
            Shirty::Http::Printify.new(RESOURCE).create(params: attributes)
          end
        end
      end
    end
  end
end
