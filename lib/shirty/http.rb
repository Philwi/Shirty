require 'httparty'

module Shirty
  module Http
    class << self
      def get(url, headers: {}, params: {})
        HTTParty.get(url, headers: headers, params: params)
      end

      def post(url, headers: {}, body: {})
        HTTParty.post(url, headers: headers, body: body)
      end
    end
  end
end
