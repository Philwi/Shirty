module Shirty
  module Entities
    class Word < ActiveRecord::Base
      has_one :image, class_name: 'Shirty::Entities::Image'
      has_one :product
    end
  end
end
