module Shirty
  module Repositories
    class Words
      include Dependencies['shirty.repositories.images']

      def not_created_images_from_words
        word_ids = images.all.pluck(:word_id).uniq

        word_entity.all.where.not(id: word_ids)
      end

      private

      def word_entity
        Shirty::Entities::Word
      end
    end
  end
end
