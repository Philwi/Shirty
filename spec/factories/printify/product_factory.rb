# rubocop:disable Metrics/ClassLength
module Printify
  class ProductFactory < ::AbstractFactory
    private

    attr_reader :image

    public

    def initialize(image: ::Printify::ImageFactory.new.create)
      @image = image
    end

    def create
      stub_upload
      ::Shirty::Interactors::Printify::Products::Create.new.call(image:)
    end

    private

    def stub_upload(product_response_attributes: default_product_response_attributes)
      allow_any_instance_of(
        ::Shirty::Http::Printify::Products
      ).to receive(:create).and_return(product_response_attributes)
    end

    def default_product_response_attributes
      {
        'id' => '5d39b411749d0a000f30e0f4',
        'title' => 'Product',
        'description' => 'Good product',
        'tags' => [
          'Home & Living',
          'Stickers'
        ],
        'options' => [
          {
            'name' => 'Size',
            'type' => 'size',
            'values' => [
              {
                'id' => 2017,
                'title' => '2x2\''
              },
              {
                'id' => 2018,
                'title' => '3x3\''
              },
              {
                'id' => 2019,
                'title' => '4x4\''
              },
              {
                'id' => 2020,
                'title' => '6x6\''
              }
            ]
          },
          {
            'name' => 'Type',
            'type' => 'surface',
            'values' => [
              {
                'id' => 2114,
                'title' => 'White'
              }
            ]
          }
        ],
        'variants' => [
          {
            'id' => 45_740,
            'sku' => '866375988',
            'cost' => 134,
            'price' => 400,
            'title' => '2x2\' / White',
            'grams' => 10,
            'is_enabled' => true,
            'is_default' => true,
            'is_available' => true,
            'options' => [
              2017,
              2114
            ]
          },
          {
            'id' => 45_742,
            'sku' => '866375989',
            'cost' => 149,
            'price' => 400,
            'title' => '3x3\' / White',
            'grams' => 10,
            'is_enabled' => true,
            'is_default' => false,
            'is_available' => true,
            'options' => [
              2018,
              2114
            ]
          }
        ],
        'images' => [
          {
            'src' => 'https://images.printify.com/mockup/5d39b411749d0a000f30e0f4/45740/2187/product.jpg',
            'variant_ids' => [
              45_740
            ],
            'position' => 'front',
            'is_default' => true
          },
          {
            'src' => 'https://images.printify.com/mockup/5d39b411749d0a000f30e0f4/45740/2188/product.jpg',
            'variant_ids' => [
              45_740
            ],
            'position' => 'front',
            'is_default' => false
          }
        ],
        'created_at' => '2019-07-25 13:52:17+00:00',
        'updated_at' => '2019-07-25 13:52:18+00:00',
        'visible' => true,
        'is_locked' => false,
        'blueprint_id' => 384,
        'user_id' => 1337,
        'shop_id' => 1337,
        'print_provider_id' => 1,
        'print_areas' => [
          {
            'variant_ids' => [
              45_740,
              45_742,
              45_744,
              45_746
            ],
            'placeholders' => [
              {
                'position' => 'front',
                'images' => [
                  {
                    'id' => '5d15ca551163cde90d7b2203',
                    'name' => 'Asset 65@3x.png',
                    'type' => 'image/png',
                    'height' => 1200,
                    'width' => 1200,
                    'x' => 0.5,
                    'y' => 0.5,
                    'scale' => 1,
                    'angle' => 0
                  }
                ]
              }
            ],
            'background' => '#ffffff'
          }
        ],
        'sales_channel_properties' => []
      }
    end
  end
end
# rubocop:enable Metrics/ClassLength
