module Shirty
  module Repositories
    class Images
      def create_with_attributes(image_path:, file_name:, mime_type:, word:, shopable:)
        image_entity.create(
          file_name: file_name,
          mime_type: mime_type,
          word: word,
          shopable_type: shopable.class.name,
          shopable_id: shopable.id,
          image_data: { path: image_path }.to_json
        )
      end

      def all
        image_entity.all
      end

      def by_id(id:)
        image_entity.find_by(id: id)
      end

      def find_by(file_name:)
        image_entity.find_by(file_name: file_name)
      end

      private

      def image_entity
        Shirty::Entities::Image
      end
    end
  end
end
