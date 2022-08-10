# frozen_string_literal: true

require 'dry/cli'
Dir['./lib/shirtie/cli/*.rb'].sort.each { |f| require f }

module Shirtie
  module Cli
    class Application < Dry::CLI
      def self.start
        new.call
      end

      def self.new(commands = Cli::Commands)
        super
      end
    end
  end
end
