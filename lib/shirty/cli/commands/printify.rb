require 'dry/cli'

module Shirty
  module Cli
    module Commands
      extend Dry::CLI::Registry

      class Printify < Dry::CLI::Command
        desc 'Printify the data'

        def call(*)
          'Printify the data'
        end
      end
    end
  end
end
