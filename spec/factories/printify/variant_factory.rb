module Printify
  class VariantFactory < ::AbstractFactory
    private

    attr_accessor :print_provider, :blueprint, :variant

    public

    def initialize(
      blueprint: Printify::BlueprintFactory.new.create,
      print_provider: Printify::PrintProviderFactory.new.create
    )

      self.blueprint = blueprint
      self.print_provider = print_provider
    end

    def create(variant_response_attributes: default_response_variant_attributes)
      stub_variant_request(variant_response_attributes: variant_response_attributes)
      ::Shirty::Operations::Printify::Variants::Sync.new.call
    end

    private

    def stub_variant_request(variant_response_attributes:)
      allow_any_instance_of(
        Shirty::Http::Printify::Variants
      ).to receive(:all_for_blueprint_and_print_provider).and_return(variant_response_attributes)
    end

    def default_response_variant_attributes
      {
        'id' => 3,
        'title' => 'DJ',
        'variants' => [
          {
            'id' => 17_390,
            'title' => 'Heather Grey / XS',
            'options' => {
              'color' => 'Heather Grey',
              'size' => 'XS'
            },
            'placeholders' => [
              {
                'position' => 'back',
                'height' => 3995,
                'width' => 3153
              },
              {
                'position' => 'front',
                'height' => 3995,
                'width' => 3153
              }
            ]
          },
          {
            'id' => 17_426,
            'title' => 'Solid Black / XS',
            'options' => {
              'color' => 'Solid Black',
              'size' => 'XS'
            },
            'placeholders' => [
              {
                'position' => 'back',
                'height' => 3995,
                'width' => 3153
              },
              {
                'position' => 'front',
                'height' => 3995,
                'width' => 3153
              }
            ]
          }
        ]
      }
    end

    # def default_response_variant_attributes
    #   {
    #     'id' => 1234,
    #     'title' => 'foo',
    #     'options' => {
    #       'color' => 'Heather Gray',
    #       'size' => 'XS'
    #     }
    #   }
    # end
  end
end
