module Shirty
  module Entities
    class Image < ActiveRecord::Base
      # include ::ImageUploader::Attachment(:image)

      # serialize :image_data, Hash

      belongs_to :word, class_name: 'Shirty::Entities::Word'
      belongs_to :shop, class_name: 'Shirty::Entities::Shop'
      has_one :printify_images, class_name: 'Shirty::Entities::Printify::Image'
    end
  end
end
