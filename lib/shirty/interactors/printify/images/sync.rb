require 'dry/transaction'

module Shirty
  module Interactors
    module Printify
      module Images
        class Sync
          include Dry::Transaction
          include Dependencies[
            api: 'shirty.http.printify.images',
            repository: 'shirty.repositories.printify.images',
            disk_image_repository: 'shirty.repositories.images',
            image_mapper: 'shirty.mapper.printify.image',
            image_service: 'shirty.interactors.images.image_service'
          ]

          step :sync_from_printify
          step :exclude_duplicates
          step :persist

          private

          def sync_from_printify(_input)
            images = api.all
            images_data = images['data']

            if images.present?
              Success(images: images_data)
            else
              Failure(:images_not_found)
            end
          end

          def exclude_duplicates(input)
            images_to_persist = input[:images].present? ? persistable_images(input[:images]) : []

            if images_to_persist.present?
              Success(persistable_images: images_to_persist)
            else
              Failure(:only_duplicates_found)
            end
          end

          def persistable_images(images)
            printify_ids_from_already_synced_images = repository.all.pluck(:printify_id)

            images.reject do |image|
              printify_ids_from_already_synced_images.include?(image['id'])
            end
          end

          def persist(input)
            input[:persistable_images].each do |image|
              mapped_attributes = image_mapper.parse(image)
              printify_image = repository.create(attributes: mapped_attributes)

              disk_image = disk_image_repository.find_by(file_name: image['file_name'])
              disk_image = create_disk_image(image['file_name']) if disk_image.blank?
              disk_image.printify_images = printify_image
              disk_image.save
            end

            Success(:images_synced)
          end

          def create_disk_image(file_name)
            image_service.create_from_file_name(file_name).success
          end
        end
      end
    end
  end
end
