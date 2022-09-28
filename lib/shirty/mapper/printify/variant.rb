module Shirty
  module Mapper
    module Printify
      class Variant
        def build_all(variants)
          variants.map do |variant|
            {
              'id' => variant.printify_id,
              'price' => 3000,
              'is_enabled' => true
            }
          end
        end
      end
    end
  end
end
