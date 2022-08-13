module Shirty
  module Entities
    class Image < ActiveRecord::Base
      include ::ImageUploader::Attachment(:image)

      belongs_to :word, class_name: 'Shirty::Entities::Word'
    end
  end
end
