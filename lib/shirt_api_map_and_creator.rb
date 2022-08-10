# frozen_string_literal: true

ENV['ENVIRONMENT'] ||= 'development'

require 'pg'
require 'active_record'
require 'dotenv'
require 'erb'
require 'yaml'

Dir[File.join(File.expand_path('..', __dir__), 'lib', 'shirt_api_map_and_creator', '**', '*.rb')].sort.each do |file|
  require file
end

Dotenv.load(".env.#{ENV.fetch('ENVIRONMENT')}.local", ".env.#{ENV.fetch('ENVIRONMENT')}", '.env')
# Method needed for loading database settings
def db_configuration
  # The method below returns the path to the file with our configuration
  db_configuration_file_path = File.join(File.expand_path('..', __dir__), 'db', 'config.yml')

  # Having the path to the file, we can read its values. Because the config.yml
  # file contains environment variables and, as you may have noticed,
  # the erb <%= %> syntax, we also need to use the erb gem. Without this,
  # the values of the variables will not be read correctly and activerecord
  # will not be able to connect to postgres.The following method will return
  # the configuration as a string

  db_configuration_result = ERB.new(File.read(db_configuration_file_path)).result

  # Using the previously added `yaml` gem, we can safely load our configuration

  YAML.safe_load(db_configuration_result, aliases: true)
end

ActiveRecord::Base.establish_connection(db_configuration[ENV['ENVIRONMENT']])

module ShirtApiMapAndCreator
  class Error < StandardError; end
  # Your code goes here...
end
