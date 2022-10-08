
module Shirty
  module Entities
    class Shop < ActiveRecord::Base
      # TODO: word noch belongs_to
      has_many :words, class_name: 'Shirty::Entities::Word'
      has_many :images, class_name: 'Shirty::Entities::Image'
    end
  end
end
