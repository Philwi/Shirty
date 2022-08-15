module Shirty
  module Http
    module Printify
      module Products
        RESOURCE = 'products'.freeze

        class << self
          def create(attributes)
            Shirty::Http::Printify.new(RESOURCE).create(params: attributes)
          end
        end
      end
    end
  end
end

# {
#     "title": "Product",
#     "description": "Good product",
#     "blueprint_id": 384,
#     "print_provider_id": 1,
#     "variants": [
#           {
#               "id": 45740,
#               "price": 400,
#               "is_enabled": true
#           },
#           {
#               "id": 45742,
#               "price": 400,
#               "is_enabled": true
#           },
#           {
#               "id": 45744,
#               "price": 400,
#               "is_enabled": false
#           },
#           {
#               "id": 45746,
#               "price": 400,
#               "is_enabled": false
#           }
#       ],
#       "print_areas": [
#         {
#           "variant_ids": [45740,45742,45744,45746],
#           "placeholders": [
#             {
#               "position": "front",
#               "images": [
#                   {
#                     "id": "5d15ca551163cde90d7b2203",
#                     "x": 0.5,
#                     "y": 0.5,
#                     "scale": 1,
#                     "angle": 0
#                   }
#               ]
#             }
#           ]
#         }
#       ]
#   }
