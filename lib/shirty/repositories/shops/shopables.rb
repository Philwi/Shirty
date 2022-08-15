module Shirty
  module Repositories
    module Shops
      class Shopables
        def create_with_attributes_for_shop(word:, shop:)
          shop.create(word: word)
        end
      end
    end
  end
end
