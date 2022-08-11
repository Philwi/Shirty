require 'dry/cli'

module Shirty
  module Cli
    module Commands
      module Images
        extend Dry::CLI::Registry

        class Create < Dry::CLI::Command
          desc 'Creates Images from words'

          def call(*)
            ::Shirty::Operations::Images::Create.new.call(word: 'hello')
          end
        end
      end
    end
  end
end
