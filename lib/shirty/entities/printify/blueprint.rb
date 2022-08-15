module Shirty
  module Entities
    module Printify
      class Blueprint < ActiveRecord::Base
        self.table_name = 'printify_blueprints'

        serialize :location, Hash

        has_many(
          :print_providers,
          class_name: 'Shirty::Entities::Printify::PrintProvider',
          foreign_key: 'printify_blueprint_id'
        )
      end
    end
  end
end
