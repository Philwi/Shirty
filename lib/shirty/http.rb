require 'httparty'

module Shirty
  module Http
    class << self
      def get(url, headers: {}, params: {})
        HTTParty.get(url, headers:, params:)
      end

      def post(url, headers: {}, body: {})
        HTTParty.post(url, headers:, body:)
      end
    end
  end
end
