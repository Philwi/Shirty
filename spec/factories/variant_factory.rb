class VariantFactory < AbstractFactory
  attr_accessor :print_provider, :blueprint, :variant

  def initialize(blueprint: BlueprintFactory.new.blueprint, print_provider: PrintProviderFactory.new.print_provider)
    self.blueprint = blueprint
    self.print_provider = print_provider
  end

  def stub_variant_request(variant_attributes: default_response_variant_attributes)
    allow_any_instance_of(
      Shirty::Http::Printify::Variants
    ).to receive(:all_for_blueprint_and_print_provider).and_return(variant_attributes)
  end

  private

  def default_response_variant_attributes
    {
      'id' => 1234,
      'title' => 'foo',
      'options' => {
        'color' => 'Heather Gray',
        'size' => 'XS'
      }
    }
  end
end
