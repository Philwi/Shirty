require 'dry/cli'

module Cli
  module Commands
    module Images
      extend Dry::CLI::Registry

      class Create < Dry::CLI::Command
        include Dependencies[
          logger: 'rainbow_logger',
          shop_repository: 'shirty.repositories.shops'
        ]

        desc 'Creates Images from words'

        option :all, default: false, desc: 'Create all images from persisted not already created words'
        argument :text_color, type: :string, required: false, desc: 'The color of the text'
        argument :shop, type: :string, required: false, desc: 'The shop to create the image for'

        def call(text_color: 'black', shop: shop_repository.last_created_shop, **options)
          @text_color = text_color
          @shop = shop

          create_all = Shirty::Helper::FetchBool.new.fetch_bool(hash: options, key: :all, default: false)
          create_all_images_from_persisted_words if create_all
        end

        private

        attr_reader :text_color, :shop

        def create_all_images_from_persisted_words
          words = ::Shirty::Repositories::Words.new.not_created_images_from_words

          words.each do |word|
            create_image_from_word(word)
          end
        end

        def create_image_from_word(word)
          result =
            ::Shirty::Interactors::Images::ImageService.new.create_from_word(word:, color: text_color, shop:)

          if result.success?
            logger.call('Image created', color: :green)
          else
            message = "Image not created: #{result.failure}"
            logger.call(message, color: :red)
          end
        end
      end
    end
  end
end
