require 'dry/cli'

module Shirty
  module Cli
    module Commands
      module Printify
        extend Dry::CLI::Registry

        class Create < Dry::CLI::Command
          desc 'Creates something'

          def call(*)
            'Creates the data'
          end
        end
      end
    end
  end
end
