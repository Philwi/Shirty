module Shirty
  module Mapper
    module Printify
      class Product
        include Dependencies[
          variant_repository: 'shirty.repositories.printify.variants',
          variant_representer: 'shirty.mapper.printify.variant'
        ]

        # rubocop:disable Metrics/MethodLength
        def build(blueprint:, image:)
          print_provider = blueprint.print_providers.sample

          return {} if print_provider.blank?

          {
            title: image.file_name,
            description: image.file_name,
            blueprint_id: blueprint.printify_id,
            print_provider_id: print_provider.printify_id,
            variants: represented_variants(blueprint:, print_provider:),
            print_areas: [
              {
                variant_ids: represented_variants(blueprint:, print_provider:).pluck('id'),
                placeholders: [
                  {
                    position: 'front',
                    images: [
                      {
                        id: image.printify_id,
                        x: 0.5,
                        y: 0.5,
                        scale: 1,
                        angle: 0
                      }
                    ]
                  }
                ]
              }
            ]
          }
        end

        def parse(attributes)
          {
            'prinfify_id' => attributes['id'],
            'title' => attributes['title'],
            'description' => attributes['description'],
            'tags' => ['tags'],
            'options' => ['options'],
            'variants' => ['variants'],
            'images' => ['images'],
            'printify_created_at' => attributes['printify_created_at'],
            'printify_updated_at' => attributes['printify_updated_at'],
            'visible' => attributes['visible'],
            'blueprint_id' => attributes['blueprint_id'],
            'print_provider_id' => attributes['print_provider_id'],
            'user_id' => attributes['user_id'],
            'shop_id' => attributes['shop_id'],
            'print_areas' => ['print_areas'],
            'print_details' => ['print_details'],
            'is_locked' => attributes['is_locked'],
            'sales_channel_properties' => ['sales_channel_properties'],
            'printify_images_id' => attributes['printify_images_id']
          }
        end
        # rubocop:enable Metrics/MethodLength

        private

        def represented_variants(blueprint:, print_provider:)
          variants = variant_repository.find_by(blueprint_id: blueprint.id, print_provider_id: print_provider.id)

          variant_representer.build_all(variants)
        end
      end
    end
  end
end
