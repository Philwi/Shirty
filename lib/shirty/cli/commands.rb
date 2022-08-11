require 'dry/cli'

module Shirty
  module Cli
    module Commands
      extend Dry::CLI::Registry

      register 'printify', ::Shirty::Cli::Commands::Printify
    end
  end
end
