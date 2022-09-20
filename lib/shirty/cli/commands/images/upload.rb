require 'dry/cli'

module Shirty
  module Cli
    module Commands
      module Images
        extend Dry::CLI::Registry

        class Upload < Dry::CLI::Command
          desc 'Upload images to Printify'

          option :all, default: false, desc: 'Upload all images not already uploaded images'
          argument :shop, type: :string, required: false, desc: 'The shop to uploade the images for'

          def call(shop: Shirty::Entities::Shops::IHateEverything, **options)
            @shop = shop

            upload_all = Shirty::Helper::FetchBool.new.fetch_bool(hash: options, key: :all, default: false)
            upload_all_images_to_printify if upload_all
          end

          private

          attr_reader :shop

          def upload_all_images_to_printify
            images = Shirty::Repositories::Images.new.all
            syncable_images(images).each do |image|
              result = Shirty::Operations::Images::Upload.new.call(id: image.id)
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

          def logger
            @logger ||= RainbowLogger.new
          end
        end
      end
    end
  end
end
