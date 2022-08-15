module Shirty
  module Entities
    module Shops
      class IHateEverything < ActiveRecord::Base
        self.table_name = 'i_hate_everything_shops'

        belongs_to :word, class_name: 'Shirty::Entities::Word'
        has_one :image, as: :shopable, class_name: 'Shirty::Entities::Image'

        SHOP_NAME = 'I Hate Everything'.freeze
        SHOP_PREFIX = 'I Hate'.freeze
      end
    end
  end
end
