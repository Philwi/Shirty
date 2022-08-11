module Shirty
  module Entities
    class Word < ActiveRecord::Base
      has_one :images, class_name: 'Shirty::Entities::Images'
    end
  end
end
