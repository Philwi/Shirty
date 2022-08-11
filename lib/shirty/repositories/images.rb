module Shirty
  module Repositories
    class Images
      include Dependencies['shirty.entities.images']

      def create(attributes)
        images = entities.images.new(attributes)
        images.save
        images
      end
    end
  end
end
