require 'dry/cli'

module Cli
  module Commands
    extend Dry::CLI::Registry

    class Setup < Dry::CLI::Command
      include Dependencies[
        logger: 'rainbow_logger',
        shop_repository: 'shirty.repositories.shops'
      ]

      desc 'Setup everything - creates words from list, creates images from words, sync all important printify stuff'

      def initialize(logger:, shop_repository:, word_list: default_word_list)
        @logger = logger
        @shop_repository = shop_repository
        @word_list = word_list
      end

      def call
        create_words
        create_internal_images
        sync_printify_stuff
        upload_images_to_printify
      end

      private

      attr_reader :word_list, :shop_repository, :logger

      def default_word_list
        words = []
        file_path = File.join(File.expand_path('../../..', __dir__), 'words.txt')

        if File.exist?(file_path)
          File.read(file_path).split("\n").each do |word|
            words << word
          end
        else
          logger.call("File #{file_path} not found", color: :red)
        end

        words
      end

      def create_words
        word_list.each do |word|
          logger.call("Create word: #{word}", color: :green)
          words_repository.create_word_by_name(word)
        end
      end

      def words_repository
        @words_repository ||= ::Shirty::Repositories::Words.new
      end

      def create_internal_images
        shop_repository.all_shops.each do |shop|
          ::Cli::Commands::Images::Create.new.call(
            text_color: 'black',
            shop: shop,
            **{ all: true }
          )
        end
      end

      def sync_printify_stuff
        ::Cli::Commands::Printify::External::Sync.new.call
      end

      def upload_images_to_printify
        ::Cli::Commands::Printify::Images::Upload.new.call(**{ all: true })
      end
    end
  end
end
