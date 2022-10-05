require 'dry/cli'

module Cli
  module Commands
    extend Dry::CLI::Registry

    register 'printify', ::Cli::Commands::Printify::Create
    register 'printify_sync', ::Cli::Commands::Printify::Sync
    register 'create_image', ::Cli::Commands::Images::Create
    register 'upload_image', ::Cli::Commands::Images::Upload
  end
end
