require 'dry/cli'

module Shirtie
  module Cli
    module Commands
      extend Dry::CLI::Registry

      register 'printify', ::Shirtie::Cli::Commands::Printify
    end
  end
end
