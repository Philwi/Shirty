require 'dry/transaction'

module Shirty
  module Interactors
    module Printify
      module Variants
        class Sync
          include Dry::Transaction
          include Dependencies[
            api: 'shirty.http.printify.variants',
            repository: 'shirty.repositories.printify.variants',
            blueprint_repository: 'shirty.repositories.printify.blueprints',
            print_provider_repository: 'shirty.repositories.printify.print_providers'
          ]

          step :ensure_blueprints
          step :get_variants_for_blueprints_print_providers_and_save_them

          private

          def ensure_blueprints(_input)
            blueprints = blueprint_repository.all

            Success({ blueprints: })
          end

          def get_variants_for_blueprints_print_providers_and_save_them(input)
            blueprints = input[:blueprints]

            variants = create_variants(blueprints)

            Success(input.merge(variants:))
          end

          def create_variants(blueprints)
            variants = []

            blueprints.includes(:print_providers).each do |blueprint|
              blueprint.print_providers.each do |print_provider|
                variant = get_variants_for(blueprint:, print_provider:)
                variants << create_variant(variant:, blueprint:, print_provider:)
              end
            end

            variants
          end

          def get_variants_for(blueprint:, print_provider:)
            api.all_for_blueprint_and_print_provider(
              blueprint:,
              print_provider:
            )
          end

          def create_variant(variant:, blueprint:, print_provider:)
            return nil if already_existing_variant?(variant['id'].to_i)

            repository.create(variant_attributes: variant, blueprint:, print_provider:)
          end

          def already_existing_variant?(printify_id)
            repository.find_by_printify_id(printify_id:).present?
          end
        end
      end
    end
  end
end
