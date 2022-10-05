require 'dry/cli'

module Cli
  module Commands
    extend Dry::CLI::Registry

    register 'setup', ::Cli::Commands::Setup
  end
end
