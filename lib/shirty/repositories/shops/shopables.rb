module Shirty
  module Repositories
    module Shops
      class Shopables
        def create_with_attributes_for_shop(word:, shop:, color:)
          if entry_already_exists_for(word: word, color: color, shop: shop)
            return find_shop_by(word: word, color: color, shop: shop)
          end

          shop.create(word: word, color: color)
        end

        private

        def entry_already_exists_for(word:, color:, shop:)
          result = find_shop_by(word: word, color: color, shop: shop)
          result.present?
        end

        def find_shop_by(word:, color:, shop:)
          shop.find_by(word: word, color: color)
        end
      end
    end
  end
end
