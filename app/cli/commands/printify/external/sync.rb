require 'dry/cli'

module Cli
  module Commands
    module Printify
      module External
        extend Dry::CLI::Registry

        class Sync < Dry::CLI::Command
          include Dependencies[
            logger: 'rainbow_logger'
          ]

          desc 'syncs everything from printify'

          argument(
            :type,
            type: :string,
            required: false,
            desc: 'What to sync. Options: all, blueprints, print_providers, variants'
          )

          # rubocop:disable Metrics/MethodLength
          def call(type: 'all', **)
            case type
            when 'all'
              sync_all_blueprints
              sync_all_print_providers
              sync_all_variants
            when 'blueprints'
              sync_all_blueprints
            when 'print_providers'
              sync_all_print_providers
            when 'variants'
              sync_all_variants
            else
              message = "Unknown type: #{type}"
              logger.call(message, color: :red)
            end
          end
          # rubocop:enable Metrics/MethodLength

          private

          def sync_all_blueprints
            result = ::Shirty::Operations::Printify::Blueprints::Sync.new.call

            if result.success?
              logger.call("Synced Blueprints: #{result.inspect}", color: :green)
            else
              message = "Not synced: #{result.failure}"
              logger.call(message, color: :red)
            end
          end

          def sync_all_print_providers
            result = ::Shirty::Operations::Printify::PrintProviders::Sync.new.call

            if result.success?
              logger.call("Synced Print Providers: #{result.inspect}", color: :green)
            else
              message = "Not synced: #{result.failure}"
              logger.call(message, color: :red)
            end
          end

          def sync_all_variants
            result = ::Shirty::Operations::Printify::Variants::Sync.new.call

            if result.success?
              logger.call("Synced Variants: #{result.inspect}", color: :green)
            else
              message = "Not synced: #{result.failure}"
              logger.call(message, color: :red)
            end
          end
        end
      end
    end
  end
end
