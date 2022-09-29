require 'dry/transaction'

module Shirty
  module Operations
    module Printify
      module Products
        class Create
          include Dry::Transaction
          include Dependencies[
            api: 'shirty.http.printify.products',
            repository: 'shirty.repositories.printify.products',
            variant_repository: 'shirty.repositories.printify.variants',
            blueprint_repository: 'shirty.repositories.printify.blueprints',
            print_provider_repository: 'shirty.repositories.printify.print_providers',
            product_mapper: 'shirty.mapper.printify.product'
          ]

          step :gather_data
          step :create_products_at_printify

          private

          def gather_data(input)
            image = input[:image]
            products = []

            blueprint_repository.all.each do |blueprint|
              products << map_product(blueprint: blueprint, image: image)
            end

            if products.present?
              Success(input.merge({ products: products }))
            else
              Failure(:no_products_to_create)
            end
          end

          def map_product(blueprint:, image:)
            product_mapper.build(blueprint: blueprint, image: image)
          end

          def create_products_at_printify(input)
            results = []

            input[:products].each do |product|
              results << create_image_and_return_api_result(product)
            end

            if results_ok?(results)
              Success(input)
            else
              Failure(:products_could_not_be_created, { results: bad_results(results) })
            end
          end

          def create_image_and_return_api_result(product)
            result = api.create(product)
            create_printify_product(result)
            result
          end

          def create_printify_product(attributes_from_printify)
            mapped_attributes = product_mapper.parse(attributes_from_printify)
            repository.create(mapped_attributes)
          end

          def results_ok?(results)
            results.none? { |result| result['errors'].present? }
          end

          def bad_results(results)
            results.select { |result| result['errors'].present? }
          end
        end
      end
    end
  end
end
