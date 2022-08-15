require 'dry/transaction'

module Shirty
  module Operations
    module Printify
      module Blueprints
        class Sync
          include Dry::Transaction
          include Dependencies[
            api: 'shirty.http.printify.blueprints',
            repository: 'shirty.repositories.printify.blueprints'
          ]

          step :ensure_input
          step :get
          step :save

          private

          def ensure_input(input)
            Success(input || {})
          end

          def get(input)
            blueprints = api.all
            Success(input.merge(blueprints: blueprints))
          end

          def save(input)
            blueprints = input[:blueprints]
            blueprints.each do |blueprint|
              repository.create(blueprint)
            end

            Success(input)
          end
        end
      end
    end
  end
end