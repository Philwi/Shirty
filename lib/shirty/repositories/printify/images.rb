module Shirty
  module Repositories
    module Printify
      class Images
        include Dependencies[
          products_repository: 'shirty.repositories.printify.products',
        ]

        def all
          image_entity.all
        end

        def create(attributes:)
          image_entity.create(attributes)
        end

        def images_without_created_products
          used_image_ids = products_repository.all.pluck(:printify_images_id)
          image_entity.where.not(id: used_image_ids)
        end

        private

        def image_entity
          ::Shirty::Entities::Printify::Image
        end
      end
    end
  end
end
