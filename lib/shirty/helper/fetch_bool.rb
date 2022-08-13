module Shirty
  module Helper
    class FetchBool
      def fetch_bool(hash:, key:, default: false)
        ActiveModel::Type::Boolean.new.cast(hash.fetch(key, default))
      end
    end
  end
end
