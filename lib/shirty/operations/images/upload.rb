require 'dry/transaction'

module Shirty
  module Operations
    module Images
      class Upload
        include Dry::Transaction
        include Dependencies[
          repository: 'shirty.repositories.images',
          api: 'shirty.http.printify.images'
        ]

        step :get_image_by_id
        step :upload_image
        step :update_attributes

        private

        def get_image_by_id(input)
          image = repository.by_id(id: input[:id])

          if image.present?
            Success(image)
          else
            Failure(:image_not_found)
          end
        end

        def upload_image(input)
          represented_attributes = represent_image_attributes(input)
          result = api.create(represented_attributes)

          if result['status'].blank?
            Success({ properites_from_printful: result, image: input })
          else
            Failure(image_not_uploaded: result['errors'])
          end
        end

        def represent_image_attributes(image)
          {
            'file_name' => image.file_name,
            'contents' => base64_encoded_image(image)
          }
        end

        def base64_encoded_image(image)
          image_data = JSON.parse image.image_data
          path = image_data['path']
          file = File.read(path)
          Base64.encode64 file
        end

        def update_attributes(input)
          properites_from_printful = input[:properites_from_printful]
          image = input[:image]
          image.height = properites_from_printful['height']
          image.width = properites_from_printful['width']
          image.size = properites_from_printful['size']
          image_data = JSON.parse(image.image_data)
          image_data.merge(
            {
              printify_id: properites_from_printful['id'],
              preview_url: properites_from_printful['preview_url']
            }
          )
          image.image_data = image_data.to_json

          if image.save
            Success(image)
          else
            Failure(:image_could_not_be_updated_from_printify_attributes)
          end
        end
      end
    end
  end
end
