require 'dry/transaction'

module Shirty
  module Operations
    module Printify
      module Images
        class Upload
          include Dry::Transaction
          include Dependencies[
            repository: 'shirty.repositories.printify.images',
            disk_image_repository: 'shirty.repositories.images',
            api: 'shirty.http.printify.images'
          ]

          step :get_image_by_id
          step :upload_image
          step :create_internal_representation

          private

          def get_image_by_id(input)
            image = disk_image_repository.by_id(id: input[:id])

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
              Success({ properties_from_printify: result, image: input })
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

          def create_internal_representation(input)
            properties_from_printful = input[:properties_from_printify]

            # TODO: Representer?
            attributes = {
              printify_id: properties_from_printful['id'],
              file_name: properties_from_printful['file_name'],
              height: properties_from_printful['height'],
              width: properties_from_printful['width'],
              size: properties_from_printful['size'],
              mime_type: properties_from_printful['mime_type'],
              upload_time: properties_from_printful['upload_time']
            }

            printify_image = repository.create(attributes: attributes)
            image = input[:image]
            image.printify_images = printify_image
            image.save

            if printify_image.present?
              Success(image)
            else
              Failure(:printify_image_could_not_be_created)
            end
          end
        end
      end
    end
  end
end
