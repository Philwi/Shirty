require 'shrine'
require 'shrine/storage/memory'
require 'shrine/storage/file_system'

# dont use shrine atm because I can not figure how to upload a file without a controller...
rails_env = ENV.fetch('RAILS_ENV', 'production')

Shrine.storages =
  if rails_env == 'test'
    {
      cache: Shrine::Storage::Memory.new,
      store: Shrine::Storage::Memory.new
    }
  else
    {
      cache: Shrine::Storage::FileSystem.new('public', prefix: 'uploads/cache'), # temporary
      store: Shrine::Storage::FileSystem.new('public', prefix: 'uploads')        # permanent
    }
  end

Shrine.plugin :activerecord # or :activerecord
Shrine.plugin :cached_attachment_data # for retaining the cached file across form redisplays
Shrine.plugin :restore_cached_data # re-extract metadata when attaching a cached file
Shrine.plugin :rack_file # for non-Rails apps
Shrine.plugin :determine_mime_type, analyzer: :mime_types
