module Shirty
  module Repositories
    module Shops
      class Shopables
        def create_with_attributes_for_shop(word:, shop:, color:)
          check_uniqueness_of_word_and_color_for_shop(word: word, color: color, shop: shop)

          shop.create(word: word, color: color)
        end

        private

        def check_uniqueness_of_word_and_color_for_shop(word:, color:, shop:)
          shop.find_by(word: word, color: color).tap do |shopable|
            if shopable
              raise 'ShopableAlreadyExistsError', "Shop: #{shop} already exists for word: #{word} and color: #{color}"
            end
          end
        end
      end
    end
  end
end
