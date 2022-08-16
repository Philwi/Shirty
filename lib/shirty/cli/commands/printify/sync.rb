require 'dry/cli'

module Shirty
  module Cli
    module Commands
      module Printify
        extend Dry::CLI::Registry

        class Sync < Dry::CLI::Command
          desc 'syncs everything from printify'

          def call(*)
            sync_all_blueprints
            sync_all_print_providers
          end

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

          def logger
            @logger ||= RainbowLogger.new
          end
        end
      end
    end
  end
end
