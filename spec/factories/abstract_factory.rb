require 'rspec/mocks'

class AbstractFactory
  include RSpec::Mocks::ExampleMethods
  self.abstract_class = true
end
