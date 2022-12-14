require 'dry/cli'

module Cli
  module Commands
    module Printify
      module Images
        extend Dry::CLI::Registry

        class Upload < Dry::CLI::Command
          include Dependencies[
            logger: 'rainbow_logger',
            shop_repository: 'shirty.repositories.shops'
          ]

          desc 'Upload images to Printify'

          option :all, default: false, desc: 'Upload all images not already uploaded images'
          argument :shop_name, type: :string, required: false, desc: 'The shop name to uploade the images for'

          def call(shop_name: 'I Hate Everything', **options)
            @shop = find_shop(shop_name)

            upload_all = Shirty::Helper::FetchBool.new.fetch_bool(hash: options, key: :all, default: false)
            upload_all_images_to_printify if upload_all
          end

          private

          attr_reader :shop

          def find_shop(shop_name)
            shop_repository.find_by_name(shop_name)
          end

          def upload_all_images_to_printify
            images = Shirty::Repositories::Images.new.all

            syncable_images(images).each do |image|
              result = Shirty::Interactors::Printify::Images::Upload.new.call(id: image.id)
              if result.success?
                logger.call("Image uploaded: #{result.inspect}", color: :green)
              else
                message = "Image not uploaded: #{result.failure}"
                logger.call(message, color: :red)
              end
            end
          end

          def syncable_images(images)
            images.select { |image| image.height.blank? }
          end
        end
      end
    end
  end
end
