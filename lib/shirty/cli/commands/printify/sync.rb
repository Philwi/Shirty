require 'dry/cli'

module Shirty
  module Cli
    module Commands
      module Printify
        extend Dry::CLI::Registry

        class Sync < Dry::CLI::Command
          desc 'syncs everything from printify'

          def call(*)
            result = ::Shirty::Operations::Printify::Blueprints::Sync.new.call

            if result.success?
              logger.call('Synced', color: :green)
            else
              message = "Not synced: #{result.failure}"
              logger.call(message, color: :red)
            end
          end

          private

          def logger
            @logger ||= RainbowLogger.new
          end
        end
      end
    end
  end
end
