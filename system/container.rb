require 'dry/system/container'

class Container < Dry::System::Container
  extend Dry::Container::Mixin

  configure do |config|
    config.root = Pathname('.')
    config.component_dirs.add 'lib'
  end
end
