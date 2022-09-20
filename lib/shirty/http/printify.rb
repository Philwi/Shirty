module Shirty
  module Http
    class Printify
      private

      attr_reader :resource, :http_client

      public

      def initialize(resource, http_client: Shirty::Http)
        @resource = resource
        @http_client = http_client
      end

      def index(params: {})
        http_client.get(request_url, headers: headers, params: params)
      end

      def create(body: {})
        http_client.post(request_url, headers: headers, body: body.to_json)
      end

      private

      def printify_url
        'https://api.printify.com/v1'
      end

      def request_url
        "#{printify_url}/#{resource}"
      end

      def headers
        api_key = ENV.fetch('PRINTIFY_API_TOKEN')

        { 'Authorization' => "Bearer #{api_key}" }
      end
    end
  end
end
