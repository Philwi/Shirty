module Shirty
  module Entities
    module Printify
      class Variant < ActiveRecord::Base
        self.table_name = 'printify_variants'

        serialize :options
      end
    end
  end
end
