module Shirty
  module Repositories
    class Shops
      def last_created_shop
        shop_entity.last
      end

      def create_shop_by_name(name)
        prefix = name.split[0..-2].join(' ')
        shop_entity.create(name: name, prefix: prefix)
      end

      def all_shops
        shop_entity.all
      end

      def find_by_name(name)
        shop_entity.find_by(name: name)
      end

      private

      def shop_entity
        ::Shirty::Entities::Shop
      end
    end
  end
end
