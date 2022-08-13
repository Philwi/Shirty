module Shirty
  module Entities
    class Word < ActiveRecord::Base
      has_one :image, class_name: 'Shirty::Entities::Image'
    end
  end
end
