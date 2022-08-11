module Shirty
  module Entities
    module Printify
      class Blueprint < ActiveRecord::Base
        self.table_name = 'printify_blueprints'
      end
    end
  end
end
