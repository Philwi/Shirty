# frozen_string_literal: true

require 'dotenv'

Dotenv.load

require 'standalone_migrations'

ENV['SCHEMA'] = File.join(ActiveRecord::Tasks::DatabaseTasks.db_dir, 'schema.rb')
StandaloneMigrations::Tasks.load_tasks

require 'rspec/core/rake_task'

RSpec::Core::RakeTask.new(:spec)

require 'rubocop/rake_task'

RuboCop::RakeTask.new

task default: %i[spec rubocop]
