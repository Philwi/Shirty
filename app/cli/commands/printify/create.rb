require 'dry/cli'

module Cli
  module Commands
    module Printify
      extend Dry::CLI::Registry

      class Create < Dry::CLI::Command
        desc 'Creates products from uploaded image which are not created yet at printify'

        def call(repository: ::Shirty::Repositories::Printify::Images.new)
          @repository = repository

          images_without_created_products.each do |image|
            create_product(image)
          end
        end

        private

        attr_reader :repository

        def images_without_created_products
          repository.images_without_created_products
        end

        def create_product(image)
          result = ::Shirty::Operations::Printify::Products::Create.new.call(image: image)

          if result.success?
            logger.call("Created Product: #{result.inspect}", color: :green)
          else
            message = "Product could not be created: #{result.failure}"
            logger.call(message, color: :red)
          end
        end

        def logger
          @logger ||= RainbowLogger.new
        end
      end
    end
  end
end
