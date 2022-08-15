require 'dry/cli'

module Shirty
  module Cli
    module Commands
      extend Dry::CLI::Registry

      register 'printify', ::Shirty::Cli::Commands::Printify::Create
      register 'printify_sync', ::Shirty::Cli::Commands::Printify::Sync
      register 'create_image', ::Shirty::Cli::Commands::Images::Create
    end
  end
end
