require 'dry/transaction'

module Shirty
  module Interactors
    module Printify
      module Images
        class Upload
          include Dry::Transaction
          include Dependencies[
            repository: 'shirty.repositories.printify.images',
            disk_image_repository: 'shirty.repositories.images',
            api: 'shirty.http.printify.images',
            image_mapper: 'shirty.mapper.printify.image'
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
            image = input[:image]
            image.printify_images = printify_image(properties_from_printify: input[:properties_from_printify])
            image_created = image.printify_images.present?
            image.save

            if image_created
              Success(image)
            else
              Failure(:printify_image_could_not_be_created)
            end
          end

          def printify_image(properties_from_printify:)
            mapped_attributes = image_mapper.parse(properties_from_printify)
            repository.create(attributes: mapped_attributes)
          end
        end
      end
    end
  end
end
