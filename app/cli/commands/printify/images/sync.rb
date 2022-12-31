require 'dry/cli'

module Cli
  module Commands
    module Printify
      module Images
        extend Dry::CLI::Registry

        class Sync < Dry::CLI::Command
          include Dependencies[logger: 'rainbow_logger']

          desc 'Sync images from Printify'

          def call
            sync_all_images_from_printify
          end

          private

          def sync_all_images_from_printify
            result = ::Shirty::Interactors::Printify::Images::Sync.new.call
            log_for_sync(result)
          end

          def log_for_sync(result)
            if result.success?
              logger.call("Synced: #{result.inspect}", color: :green)
            else
              logger.call("Not synced: #{result.failure}", color: :red)
            end
          end
        end
      end
    end
  end
end
