require 'dry/cli'

module Cli
  module Commands
    extend Dry::CLI::Registry

    class Setup < Dry::CLI::Command
      desc 'Setup everything - creates words from list, creates images from words, sync all important printify stuff'

      def call
        create_words
        create_internal_images
        sync_printify_stuff
        upload_images_to_printify
      end

      private

      def create_words
        file_path = File.join(File.expand_path('..', __dir__), 'words.txt')

        if File.exist?(file_path)
          File.read(file_path).split("\n").each do |word|
            logger.call("Create word: #{word}", color: :green)
            ::Shirty::Entities::Word.create(name: word)
          end
        else
          logger.call("File #{file_path} not found", color: :red)
        end
      end

      def create_internal_images
        ::Cli::Commands::Images::Create.call(
          text_color: 'black',
          shop: Shirty::Entities::Shops::IHateEverything,
          **{ all: true }
        )
      end

      def sync_printify_stuff
        ::Cli::Commands::Printify::Sync.call
      end

      def upload_images_to_printify
        ::Cli::Commands::Printify::Images::Upload.call(**{ all: true })
      end

      def logger
        @logger ||= RainbowLogger.new
      end
    end
  end
end
