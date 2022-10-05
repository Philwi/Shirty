require 'dry/cli'

module Cli
  module Commands
    extend Dry::CLI::Registry

    register 'setup', ::Cli::Commands::Setup
    # TODO: register 'add_word' # only add a new word to the database
    # TODO: register 'create_products' # runs the whole lifecycle if necessary -> image create, upload, product creation
  end
end
