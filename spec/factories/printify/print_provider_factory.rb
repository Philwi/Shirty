module Printify
  class PrintProviderFactory < AbstractFactory
    private

    attr_writer :print_provider
    attr_accessor :blueprint

    public

    def initialize(blueprint: Printify::BlueprintFactory.new.blueprint)
      self.blueprint = blueprint
    end

    def create(response_print_provider_attributes: default_response_print_provider_attributes)
      stub_print_provider_request(response_print_provider_attributes:)
      ::Shirty::Interactors::Printify::PrintProviders::Sync.new.call
    end

    private

    def stub_print_provider_request(response_print_provider_attributes:)
      allow_any_instance_of(
        Shirty::Http::Printify::PrintProviders
      ).to receive(:all_for_blueprint).and_return(response_print_provider_attributes)
    end

    def default_print_provider_attributes
      {
        'printify_id' => '1',
        'name' => 'Amazon',
        'url' => 'https:\/\/www.amazon.com\/dp\/B07JZQQQQQ'
      }
    end

    def default_response_print_provider_attributes
      [
        {
          'id' => 1,
          'name' => 'Amazon',
          'url' => 'https:\/\/www.amazon.com\/dp\/B07JZQQQQQ'
        },
        {
          'id' => 2,
          'name' => 'Ebay',
          'url' => 'https:\/\/www.ebay.com\/itm\/Kids-Regular-Fit-Tee-\/170785670291'
        }
      ]
    end
  end
end
