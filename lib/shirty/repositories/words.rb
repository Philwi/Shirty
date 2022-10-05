module Shirty
  module Repositories
    class Words
      include Dependencies['shirty.repositories.images']

      def all_words
        word_entity.all
      end

      def create_word_by_name(name)
        word_entity.find_or_create_by(name: name)
      end

      def not_created_images_from_words
        word_ids = images.all.pluck(:word_id).uniq

        word_entity.all.where.not(id: word_ids)
      end

      def last_created_word
        word_entity.last
      end

      private

      def word_entity
        Shirty::Entities::Word
      end
    end
  end
end
