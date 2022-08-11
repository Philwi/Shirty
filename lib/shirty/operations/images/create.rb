require 'dry/transaction'
require 'rmagick'

module Shirty
  module Operations
    module Images
      class Create
        include Dry::Transaction
        include Dependencies['shirty.repositories.images']

        step :get_word
        step :create_image_from_word
        step :create_image

        private

        def get_word(input)
          Success(input[:word])
        end

        def create_image_from_word(word)
          Success(word: word, image_path: create_image_with_text(word))
        end

        def create_image(input)
          # TODO: refactor this mess
          # TODO: dont use the entity instance!
          # TODO: use the repository instance!
          # TODO: do the magic internally
          images.images.words_id = 1
          images.images.image_data = ImageUploader.upload(File.open(input[:image_path], binmode: true), :store)
          images.images.file_name = "#{input[:word]}.png"
          images.images.mime_type = 'image/png'

          if images.images.save
            Success(images)
          else
            Failure(images.errors)
          end
        end

        def create_image_with_text(word)
          image = Magick::Image.new(200, 200)
          text = Magick::Draw.new
          text.annotate(image, 0, 0, 0, 0, word) do
            text.gravity = Magick::CenterGravity
            text.pointsize = 36
            text.font_family = 'Verdana'
            text.stroke = 'transparent'
            text.fill = '#000000'
          end
          image_path = "tmp/#{word}.png"
          image.write(image_path)
          image_path
        end
      end
    end
  end
end
