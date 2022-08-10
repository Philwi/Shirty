require 'dry/cli'
require_relative './commands/printify'

module Shirtie
  module Cli
    module Commands
      extend Dry::CLI::Registry

      register 'printify', ::Shirtie::Cli::Commands::Printify
    end
  end
end
