require 'dry/transaction'
require 'rmagick'

module Shirty
  module Operations
    module Images
      class Create
        include Dry::Transaction
        include Dependencies['shirty.repositories.images', 'shirty.repositories.words']

        step :ensure_word
        step :create_image_from_word
        step :write_image_to_file
        step :create_image

        private

        def ensure_word(input)
          word = input[:word]

          return Failure(:word_not_given) if word.nil?
          return Failure(:word_not_valid_class) unless word.is_a?(::Shirty::Entities::Word)

          Success(word)
        end

        def create_image_from_word(word)
          Success(word: word, image: create_image_with_text(word))
        end

        def write_image_to_file(input)
          image_path = "tmp/#{input[:word].name}.png"
          input[:image].write(image_path)
          input.merge!({ image_path: image_path })
          Success(input)
        end

        def create_image(input)
          result =
            images.create_with_attributes(
              image_path: input[:image_path],
              file_name: "#{input[:word].name}.png",
              mime_type: 'image/png',
              word: input[:word]
            )

          result ? Success(input) : Failure(:image_not_created)
        end

        def create_image_with_text(word)
          image = Magick::Image.new(200, 200)
          text = Magick::Draw.new
          text.annotate(image, 0, 0, 0, 0, word.name) do
            text.gravity = Magick::CenterGravity
            text.pointsize = 36
            text.font_family = 'Verdana'
            text.stroke = 'transparent'
            text.fill = '#000000'
          end
          image
        end
      end
    end
  end
end
