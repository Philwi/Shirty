# frozen_string_literal => true

require 'spec_helper'

RSpec.describe ::Cli::Commands::Printify::Create do
  subject { described_class.new }

  before do
    create_state
  end

  it 'creates products at printify' do
    stub_product_create_requests

    expect { subject.call }.to change(
      Shirty::Repositories::Printify::Products.new.all, :count
    ).by(2)
  end

  private

  def create_state
    create_printify_image
    create_blueprints
  end

  def create_printify_image
    ::Printify::ImageFactory.new.create
  end

  def create_blueprints
    2.times do
      Printify::BlueprintFactory.new.create
    end
  end

  def stub_product_create_requests
    allow_any_instance_of(
      ::Shirty::Http::Printify::Products
    ).to receive(:create).and_return(default_product_response_attributes)
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
        },
        {
          'id' => 45_744,
          'sku' => '866375990',
          'cost' => 187,
          'price' => 400,
          'title' => '4x4\' / White',
          'grams' => 10,
          'is_enabled' => true,
          'is_default' => false,
          'is_available' => true,
          'options' => [
            2019,
            2114
          ]
        },
        {
          'id' => 45_746,
          'sku' => '866375991',
          'cost' => 216,
          'price' => 400,
          'title' => '6x6\' / White',
          'grams' => 10,
          'is_enabled' => true,
          'is_default' => false,
          'is_available' => true,
          'options' => [
            2020,
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
        },
        {
          'src' => 'https://images.printify.com/mockup/5d39b411749d0a000f30e0f4/45740/2189/product.jpg',
          'variant_ids' => [
            45_740
          ],
          'position' => 'front',
          'is_default' => false
        },
        {
          'src' => 'https://images.printify.com/mockup/5d39b411749d0a000f30e0f4/45740/2190/product.jpg',
          'variant_ids' => [
            45_740
          ],
          'position' => 'front',
          'is_default' => false
        },
        {
          'src' => 'https://images.printify.com/mockup/5d39b411749d0a000f30e0f4/45740/2191/product.jpg',
          'variant_ids' => [
            45_740
          ],
          'position' => 'front',
          'is_default' => false
        },
        {
          'src' => 'https://images.printify.com/mockup/5d39b411749d0a000f30e0f4/45740/2192/product.jpg',
          'variant_ids' => [
            45_740
          ],
          'position' => 'front',
          'is_default' => false
        },
        {
          'src' => 'https://images.printify.com/mockup/5d39b411749d0a000f30e0f4/45740/2193/product.jpg',
          'variant_ids' => [
            45_740
          ],
          'position' => 'front',
          'is_default' => false
        },
        {
          'src' => 'https://images.printify.com/mockup/5d39b411749d0a000f30e0f4/45740/2194/product.jpg',
          'variant_ids' => [
            45_740
          ],
          'position' => 'front',
          'is_default' => false
        },
        {
          'src' => 'https://images.printify.com/mockup/5d39b411749d0a000f30e0f4/45740/2195/product.jpg',
          'variant_ids' => [
            45_740
          ],
          'position' => 'front',
          'is_default' => false
        },
        {
          'src' => 'https://images.printify.com/mockup/5d39b411749d0a000f30e0f4/45740/2196/product.jpg',
          'variant_ids' => [
            45_740
          ],
          'position' => 'front',
          'is_default' => false
        },
        {
          'src' => 'https://images.printify.com/mockup/5d39b411749d0a000f30e0f4/45740/2197/product.jpg',
          'variant_ids' => [
            45_740
          ],
          'position' => 'front',
          'is_default' => false
        },
        {
          'src' => 'https://images.printify.com/mockup/5d39b411749d0a000f30e0f4/45740/2198/product.jpg',
          'variant_ids' => [
            45_740
          ],
          'position' => 'front',
          'is_default' => false
        },
        {
          'src' => 'https://images.printify.com/mockup/5d39b411749d0a000f30e0f4/45740/2199/product.jpg',
          'variant_ids' => [
            45_740
          ],
          'position' => 'front',
          'is_default' => false
        },
        {
          'src' => 'https://images.printify.com/mockup/5d39b411749d0a000f30e0f4/45740/2200/product.jpg',
          'variant_ids' => [
            45_740
          ],
          'position' => 'front',
          'is_default' => false
        },
        {
          'src' => 'https://images.printify.com/mockup/5d39b411749d0a000f30e0f4/45740/2201/product.jpg',
          'variant_ids' => [
            45_740
          ],
          'position' => 'front',
          'is_default' => false
        },
        {
          'src' => 'https://images.printify.com/mockup/5d39b411749d0a000f30e0f4/45740/2202/product.jpg',
          'variant_ids' => [
            45_740
          ],
          'position' => 'front',
          'is_default' => false
        },
        {
          'src' => 'https://images.printify.com/mockup/5d39b411749d0a000f30e0f4/45742/2187/product.jpg',
          'variant_ids' => [
            45_742
          ],
          'position' => 'front',
          'is_default' => false
        },
        {
          'src' => 'https://images.printify.com/mockup/5d39b411749d0a000f30e0f4/45742/2188/product.jpg',
          'variant_ids' => [
            45_742
          ],
          'position' => 'front',
          'is_default' => false
        },
        {
          'src' => 'https://images.printify.com/mockup/5d39b411749d0a000f30e0f4/45742/2189/product.jpg',
          'variant_ids' => [
            45_742
          ],
          'position' => 'front',
          'is_default' => true
        },
        {
          'src' => 'https://images.printify.com/mockup/5d39b411749d0a000f30e0f4/45742/2190/product.jpg',
          'variant_ids' => [
            45_742
          ],
          'position' => 'front',
          'is_default' => false
        },
        {
          'src' => 'https://images.printify.com/mockup/5d39b411749d0a000f30e0f4/45742/2191/product.jpg',
          'variant_ids' => [
            45_742
          ],
          'position' => 'front',
          'is_default' => false
        },
        {
          'src' => 'https://images.printify.com/mockup/5d39b411749d0a000f30e0f4/45742/2192/product.jpg',
          'variant_ids' => [
            45_742
          ],
          'position' => 'front',
          'is_default' => false
        },
        {
          'src' => 'https://images.printify.com/mockup/5d39b411749d0a000f30e0f4/45742/2193/product.jpg',
          'variant_ids' => [
            45_742
          ],
          'position' => 'front',
          'is_default' => false
        },
        {
          'src' => 'https://images.printify.com/mockup/5d39b411749d0a000f30e0f4/45742/2194/product.jpg',
          'variant_ids' => [
            45_742
          ],
          'position' => 'front',
          'is_default' => false
        },
        {
          'src' => 'https://images.printify.com/mockup/5d39b411749d0a000f30e0f4/45742/2195/product.jpg',
          'variant_ids' => [
            45_742
          ],
          'position' => 'front',
          'is_default' => false
        },
        {
          'src' => 'https://images.printify.com/mockup/5d39b411749d0a000f30e0f4/45742/2196/product.jpg',
          'variant_ids' => [
            45_742
          ],
          'position' => 'front',
          'is_default' => false
        },
        {
          'src' => 'https://images.printify.com/mockup/5d39b411749d0a000f30e0f4/45742/2197/product.jpg',
          'variant_ids' => [
            45_742
          ],
          'position' => 'front',
          'is_default' => false
        },
        {
          'src' => 'https://images.printify.com/mockup/5d39b411749d0a000f30e0f4/45742/2198/product.jpg',
          'variant_ids' => [
            45_742
          ],
          'position' => 'front',
          'is_default' => false
        },
        {
          'src' => 'https://images.printify.com/mockup/5d39b411749d0a000f30e0f4/45742/2199/product.jpg',
          'variant_ids' => [
            45_742
          ],
          'position' => 'front',
          'is_default' => false
        },
        {
          'src' => 'https://images.printify.com/mockup/5d39b411749d0a000f30e0f4/45742/2200/product.jpg',
          'variant_ids' => [
            45_742
          ],
          'position' => 'front',
          'is_default' => false
        },
        {
          'src' => 'https://images.printify.com/mockup/5d39b411749d0a000f30e0f4/45742/2201/product.jpg',
          'variant_ids' => [
            45_742
          ],
          'position' => 'front',
          'is_default' => false
        },
        {
          'src' => 'https://images.printify.com/mockup/5d39b411749d0a000f30e0f4/45742/2202/product.jpg',
          'variant_ids' => [
            45_742
          ],
          'position' => 'front',
          'is_default' => false
        },
        {
          'src' => 'https://images.printify.com/mockup/5d39b411749d0a000f30e0f4/45744/2187/product.jpg',
          'variant_ids' => [
            45_744
          ],
          'position' => 'front',
          'is_default' => false
        },
        {
          'src' => 'https://images.printify.com/mockup/5d39b411749d0a000f30e0f4/45744/2188/product.jpg',
          'variant_ids' => [
            45_744
          ],
          'position' => 'front',
          'is_default' => false
        },
        {
          'src' => 'https://images.printify.com/mockup/5d39b411749d0a000f30e0f4/45744/2189/product.jpg',
          'variant_ids' => [
            45_744
          ],
          'position' => 'front',
          'is_default' => false
        },
        {
          'src' => 'https://images.printify.com/mockup/5d39b411749d0a000f30e0f4/45744/2190/product.jpg',
          'variant_ids' => [
            45_744
          ],
          'position' => 'front',
          'is_default' => true
        },
        {
          'src' => 'https://images.printify.com/mockup/5d39b411749d0a000f30e0f4/45744/2191/product.jpg',
          'variant_ids' => [
            45_744
          ],
          'position' => 'front',
          'is_default' => false
        },
        {
          'src' => 'https://images.printify.com/mockup/5d39b411749d0a000f30e0f4/45744/2192/product.jpg',
          'variant_ids' => [
            45_744
          ],
          'position' => 'front',
          'is_default' => false
        },
        {
          'src' => 'https://images.printify.com/mockup/5d39b411749d0a000f30e0f4/45744/2193/product.jpg',
          'variant_ids' => [
            45_744
          ],
          'position' => 'front',
          'is_default' => false
        },
        {
          'src' => 'https://images.printify.com/mockup/5d39b411749d0a000f30e0f4/45744/2194/product.jpg',
          'variant_ids' => [
            45_744
          ],
          'position' => 'front',
          'is_default' => false
        },
        {
          'src' => 'https://images.printify.com/mockup/5d39b411749d0a000f30e0f4/45744/2195/product.jpg',
          'variant_ids' => [
            45_744
          ],
          'position' => 'front',
          'is_default' => false
        },
        {
          'src' => 'https://images.printify.com/mockup/5d39b411749d0a000f30e0f4/45744/2196/product.jpg',
          'variant_ids' => [
            45_744
          ],
          'position' => 'front',
          'is_default' => false
        },
        {
          'src' => 'https://images.printify.com/mockup/5d39b411749d0a000f30e0f4/45744/2197/product.jpg',
          'variant_ids' => [
            45_744
          ],
          'position' => 'front',
          'is_default' => false
        },
        {
          'src' => 'https://images.printify.com/mockup/5d39b411749d0a000f30e0f4/45744/2198/product.jpg',
          'variant_ids' => [
            45_744
          ],
          'position' => 'front',
          'is_default' => false
        },
        {
          'src' => 'https://images.printify.com/mockup/5d39b411749d0a000f30e0f4/45744/2199/product.jpg',
          'variant_ids' => [
            45_744
          ],
          'position' => 'front',
          'is_default' => false
        },
        {
          'src' => 'https://images.printify.com/mockup/5d39b411749d0a000f30e0f4/45744/2200/product.jpg',
          'variant_ids' => [
            45_744
          ],
          'position' => 'front',
          'is_default' => false
        },
        {
          'src' => 'https://images.printify.com/mockup/5d39b411749d0a000f30e0f4/45744/2201/product.jpg',
          'variant_ids' => [
            45_744
          ],
          'position' => 'front',
          'is_default' => false
        },
        {
          'src' => 'https://images.printify.com/mockup/5d39b411749d0a000f30e0f4/45744/2202/product.jpg',
          'variant_ids' => [
            45_744
          ],
          'position' => 'front',
          'is_default' => false
        },
        {
          'src' => 'https://images.printify.com/mockup/5d39b411749d0a000f30e0f4/45746/2187/product.jpg',
          'variant_ids' => [
            45_746
          ],
          'position' => 'front',
          'is_default' => false
        },
        {
          'src' => 'https://images.printify.com/mockup/5d39b411749d0a000f30e0f4/45746/2188/product.jpg',
          'variant_ids' => [
            45_746
          ],
          'position' => 'front',
          'is_default' => false
        },
        {
          'src' => 'https://images.printify.com/mockup/5d39b411749d0a000f30e0f4/45746/2189/product.jpg',
          'variant_ids' => [
            45_746
          ],
          'position' => 'front',
          'is_default' => false
        },
        {
          'src' => 'https://images.printify.com/mockup/5d39b411749d0a000f30e0f4/45746/2190/product.jpg',
          'variant_ids' => [
            45_746
          ],
          'position' => 'front',
          'is_default' => false
        },
        {
          'src' => 'https://images.printify.com/mockup/5d39b411749d0a000f30e0f4/45746/2191/product.jpg',
          'variant_ids' => [
            45_746
          ],
          'position' => 'front',
          'is_default' => true
        },
        {
          'src' => 'https://images.printify.com/mockup/5d39b411749d0a000f30e0f4/45746/2192/product.jpg',
          'variant_ids' => [
            45_746
          ],
          'position' => 'front',
          'is_default' => false
        },
        {
          'src' => 'https://images.printify.com/mockup/5d39b411749d0a000f30e0f4/45746/2193/product.jpg',
          'variant_ids' => [
            45_746
          ],
          'position' => 'front',
          'is_default' => false
        },
        {
          'src' => 'https://images.printify.com/mockup/5d39b411749d0a000f30e0f4/45746/2194/product.jpg',
          'variant_ids' => [
            45_746
          ],
          'position' => 'front',
          'is_default' => false
        },
        {
          'src' => 'https://images.printify.com/mockup/5d39b411749d0a000f30e0f4/45746/2195/product.jpg',
          'variant_ids' => [
            45_746
          ],
          'position' => 'front',
          'is_default' => false
        },
        {
          'src' => 'https://images.printify.com/mockup/5d39b411749d0a000f30e0f4/45746/2196/product.jpg',
          'variant_ids' => [
            45_746
          ],
          'position' => 'front',
          'is_default' => false
        },
        {
          'src' => 'https://images.printify.com/mockup/5d39b411749d0a000f30e0f4/45746/2197/product.jpg',
          'variant_ids' => [
            45_746
          ],
          'position' => 'front',
          'is_default' => false
        },
        {
          'src' => 'https://images.printify.com/mockup/5d39b411749d0a000f30e0f4/45746/2198/product.jpg',
          'variant_ids' => [
            45_746
          ],
          'position' => 'front',
          'is_default' => false
        },
        {
          'src' => 'https://images.printify.com/mockup/5d39b411749d0a000f30e0f4/45746/2199/product.jpg',
          'variant_ids' => [
            45_746
          ],
          'position' => 'front',
          'is_default' => false
        },
        {
          'src' => 'https://images.printify.com/mockup/5d39b411749d0a000f30e0f4/45746/2200/product.jpg',
          'variant_ids' => [
            45_746
          ],
          'position' => 'front',
          'is_default' => false
        },
        {
          'src' => 'https://images.printify.com/mockup/5d39b411749d0a000f30e0f4/45746/2201/product.jpg',
          'variant_ids' => [
            45_746
          ],
          'position' => 'front',
          'is_default' => false
        },
        {
          'src' => 'https://images.printify.com/mockup/5d39b411749d0a000f30e0f4/45746/2202/product.jpg',
          'variant_ids' => [
            45_746
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
