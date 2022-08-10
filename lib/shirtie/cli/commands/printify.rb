require 'dry/cli'

module Shirtie
  module Cli
    module Commands
      extend Dry::CLI::Registry

      class Printify < Dry::CLI::Command
        desc 'Printify the data'

        def call(*)
          puts 'Printify the data'
          puts ::Shirtie::App::Models::Word.all
        end
      end
    end
  end
end
