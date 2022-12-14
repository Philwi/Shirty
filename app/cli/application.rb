# frozen_string_literal: true

require 'dry/cli'
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
