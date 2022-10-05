require 'dry/cli'

module Cli
  module Commands
    module Printify
      module Products
        extend Dry::CLI::Registry

        class Create < Dry::CLI::Command
          include Dependencies[
            repository: 'shirty.repositories.printify.images',
            logger: 'rainbow_logger'
          ]

          desc 'Creates products from uploaded image which are not created yet at printify'

          def call
            images_without_created_products.each do |image|
              create_product(image)
            end
          end

          private

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
        end
      end
    end
  end
end
