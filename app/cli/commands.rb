require 'dry/cli'

module Cli
  module Commands
    extend Dry::CLI::Registry

    register 'setup', ::Cli::Commands::Setup
    register 'create_products', ::Cli::Commands::Printify::Products::Create
    # TODO: runs the whole lifecycle if necessary -> image create, upload, product creation
  end
end
