require 'rmagick'
require 'dry/monads/all'

module Shirty
  module Interactors
    module Images
      class ImageService
        include Dry::Monads
        include Dependencies[
          'shirty.repositories.images',
          'shirty.repositories.words',
          'shirty.repositories.shops',
        ]

        def create_from_word(word:, color:, shop:)
          @word = word
          @color = color
          @shop = shop

          return Failure(:word_not_given) if word.blank?
          return Failure(:color_not_valid) unless color_valid?
          return Failure(:shop_not_valid) if shop.blank? || prefix_for_shop.blank?

          create_image
        end

        # TODO: delegete from file and from word creation to own class
        def create_from_file_name(file_name)
          @shop = shop_from_file_name(file_name)
          @word = word_from_file_name(file_name)
          @color = color_from_file_name(file_name)

          return Failure(:word_not_valid) if word.blank?
          return Failure(:color_not_valid) unless color_valid?
          return Failure(:shop_not_valid) if shop.blank? || prefix_for_shop.blank?

          create_image
        end

        private

        VALID_COLORS = {
          black: '#000000',
          white: '#FFFFFF'
        }.freeze

        attr_reader :word, :color, :shop

        def shop_from_file_name(file_name)
          shop_prefix = file_name.split('_').first
          shops.find_by_prefix(shop_prefix)
        end

        def word_from_file_name(file_name)
          word_name = file_name.split('_').second
          words.find_by_name(word_name)
        end

        def color_from_file_name(file_name)
          image_extension = '.png'
          file_name.split('_').third.sub(image_extension, '')
        end

        def color_valid?
          VALID_COLORS.keys.include?(color.to_sym)
        end

        def prefix_for_shop
          shop.prefix
        end

        def draw_image
          image = init_image
          text = Magick::Draw.new

          text.annotate(image, 0, 0, 0, 0, image_text) do
            text.gravity = Magick::CenterGravity
            text.pointsize = 36
            text.font_family = 'Noto Serif Display'
            text.stroke = 'transparent'
            text.fill = VALID_COLORS[color.to_sym]
          end

          image
        end

        def image_text
          name = word.name
          "#{prefix_for_shop}\n#{name}".upcase
        end

        def init_image
          Magick::Image.new(400, 200) do |canvas|
            canvas.background_color = 'none'
          end
        end

        def create_image
          result =
            images.create_with_attributes(
              image_path: image_path,
              file_name: file_name,
              mime_type: 'image/png',
              word: word,
              shop: shop
            )

          result ? Success(result) : Failure(:image_not_created)
        end

        def image_path
          "tmp/#{file_name}"
        end

        def file_name
          "#{prefix_for_shop}_#{word.name}_#{color}.png"
        end
      end
    end
  end
end
