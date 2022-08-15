module Shirty
  module Repositories
    class Images
      def create_with_attributes(image_path:, file_name:, mime_type:, word:, shopable:)
        image = ImageUploader.upload(File.open(image_path, binmode: true), :store)
        image_entity.new(
          image: image,
          file_name: file_name,
          mime_type: mime_type,
          word: word,
          shopable_type: shopable.class.name,
          shopable_id: shopable.id
        ).save
      end

      def all
        image_entity.all
      end

      private

      def image_entity
        Shirty::Entities::Image
      end
    end
  end
end
