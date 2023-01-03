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
        paginate_all_possible_entries(params:)
      end

      def create(body: {})
        http_client.post(request_url, headers:, body: body.to_json)
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

      ENTRIES_PER_PAGE = 100

      def paginate_all_possible_entries(params:)
        params_with_limit = params.deep_dup.merge('limit' => ENTRIES_PER_PAGE)
        response = fetch(params: params_with_limit)

        return response unless response.respond_to?(:keys)
        return response if response['total'] < ENTRIES_PER_PAGE

        result = loop_over_pages(params: params_with_limit, data: response['data'], total: response['total'])
        { 'data' => result }
      end

      def loop_over_pages(params:, data:, total:)
        result = data
        page = 1

        while result.count < total
          page += 1
          response = fetch(params: params.merge('page' => page))
          result << response['data']
        end

        result
      end

      def fetch(params:)
        http_client.get(request_url, headers:, params:)
      end
    end
  end
end
