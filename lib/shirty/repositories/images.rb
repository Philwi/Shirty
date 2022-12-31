module Shirty
  module Repositories
    class Images
      def create_with_attributes(image_path:, file_name:, mime_type:, word:, shop:)
        image_entity.create(
          file_name:,
          mime_type:,
          word:,
          shop:,
          image_data: { path: image_path }.to_json
        )
      end

      def all
        image_entity.all
      end

      def by_id(id:)
        image_entity.find_by(id:)
      end

      def find_by(file_name:)
        image_entity.find_by(file_name:)
      end

      def delete_all_images
        image_entity.delete_all
      end

      private

      def image_entity
        Shirty::Entities::Image
      end
    end
  end
end
