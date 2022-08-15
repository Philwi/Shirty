require 'dry/transaction'

module Shirty
  module Operations
    module Printify
      module PrintProviders
        class Sync
          include Dry::Transaction
          include Dependencies[
            api: 'shirty.http.printify.print_providers',
            repository: 'shirty.repositories.printify.print_providers',
            blueprint_repository: 'shirty.repositories.printify.blueprints'
          ]

          step :ensure_blueprints
          step :get_print_providers_for_blueprints_and_save_them

          private

          def ensure_blueprints(_input)
            blueprints = blueprint_repository.all

            Success({ blueprints: blueprints })
          end

          def get_print_providers_for_blueprints_and_save_them(input)
            blueprints = input[:blueprints]

            blueprints.each do |blueprint|
              print_providers = api.all_for_blueprint(blueprint)

              print_providers.each do |print_provider|
                next if already_existing_print_provider(print_provider: print_provider, blueprint: blueprint)

                repository.create(print_provider_attributes: print_provider, blueprint: blueprint)
              end
            end

            Success(input)
          end

          def already_existing_print_provider(print_provider:, blueprint:)
            repository.find_by_printify_id_and_blueprint(
              printify_id: print_provider['id'].to_i,
              blueprint: blueprint
            ).present?
          end
        end
      end
    end
  end
end
