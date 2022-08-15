require 'dry/transaction'
require 'rmagick'

module Shirty
  module Operations
    module Images
      class Create
        include Dry::Transaction
        include Dependencies[
          'shirty.repositories.images',
          'shirty.repositories.words',
          'shirty.repositories.shops.shopables',
        ]

        step :ensure_word
        step :ensure_color
        step :ensure_prefix
        step :create_image_from_word
        step :write_image_to_file
        step :create_image

        private

        VALID_COLORS = {
          black: '#000000',
          white: '#FFFFFF'
        }.freeze

        def ensure_word(input)
          word = input[:word]

          return Failure(:word_not_given) if word.nil?
          return Failure(:word_not_valid_class) unless word.is_a?(::Shirty::Entities::Word)

          Success(input)
        end

        def ensure_color(input)
          color = input[:color]

          if !color.nil? && color_valid?(color)
            Success(input.merge(color: color))
          else
            Failure(:color_not_valid)
          end
        end

        def ensure_prefix(input)
          shop = input[:shop]
          return Failure(:shop_not_given) if shop.nil?

          prefix = shop.const_get(:SHOP_PREFIX)

          if prefix.nil?
            Failure(:shop_not_valid)
          else
            Success(input.merge(prefix: prefix, shop: shop))
          end
        end

        def color_valid?(color)
          VALID_COLORS.keys.include?(color.to_sym)
        end

        def create_image_from_word(input)
          Success(
            input.merge(
              image: create_image_with_text(
                word: input[:word],
                prefix: input[:prefix],
                color: input[:color]
              )
            )
          )
        end

        def write_image_to_file(input)
          image_path = "tmp/#{file_name(word: input[:word], prefix: input[:prefix], color: input[:color])}"
          input[:image].write(image_path)
          input.merge!({ image_path: image_path })
          Success(input)
        end

        def create_image(input)
          shopable =
            shopables.create_with_attributes_for_shop(word: input[:word], shop: input[:shop], color: input[:color])

          result =
            images.create_with_attributes(
              image_path: input[:image_path],
              file_name: file_name(word: input[:word], prefix: input[:prefix], color: input[:color]),
              mime_type: 'image/png',
              word: input[:word],
              shopable: shopable
            )

          result ? Success(input) : Failure(:image_not_created)
        end

        def file_name(word:, prefix:, color:)
          "#{prefix}_#{word.name}_#{color}.png"
        end

        def create_image_with_text(word:, prefix:, color:)
          image = init_image
          text = Magick::Draw.new

          text.annotate(image, 0, 0, 0, 0, image_text(word: word, prefix: prefix)) do
            text.gravity = Magick::CenterGravity
            text.pointsize = 36
            text.font_family = 'Noto Serif Display'
            text.stroke = 'transparent'
            text.fill = VALID_COLORS[color.to_sym]
          end

          image
        end

        def image_text(word:, prefix:)
          name = word.name
          "#{prefix}\n#{name}".upcase
        end

        def init_image
          Magick::Image.new(400, 200) do |canvas|
            canvas.background_color = 'none'
          end
        end
      end
    end
  end
end
