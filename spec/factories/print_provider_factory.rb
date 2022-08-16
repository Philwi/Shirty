class PrintProviderFactory < AbstractFactory
  attr_accessor :print_provider, :blueprint

  def initialize(blueprint: BlueprintFactory.new.blueprint)
    self.blueprint = blueprint
  end

  def create_print_provider(print_provider_attributes: default_print_provider_attributes)
    self.print_provider =
      ::Shirty::Repositories::Printify::PrintProviders.new.create(
        print_provider_attributes: print_provider_attributes,
        blueprint: blueprint
      )
  end

  def stub_print_provider_request(print_provider_attributes: default_response_print_provider_attributes)
    allow_any_instance_of(
      Shirty::Http::Printify::PrintProviders
    ).to receive(:all_for_blueprint).and_return(print_provider_attributes)
  end

  private

  def default_print_provider_attributes
    {
      printify_id: '1',
      name: 'Amazon',
      url: 'https:\/\/www.amazon.com\/dp\/B07JZQQQQQ'
    }
  end

  def default_response_print_provider_attributes
    [
      {
        'id': 1,
        'name': 'Amazon',
        'url': 'https:\/\/www.amazon.com\/dp\/B07JZQQQQQ'
      },
      {
        'id': 2,
        'name': 'Ebay',
        'url': 'https:\/\/www.ebay.com\/itm\/Kids-Regular-Fit-Tee-\/170785670291'
      }
    ]
  end
end
