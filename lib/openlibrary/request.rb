require 'rest-client'
require 'json'

module Openlibrary
  module Request
    API_URL     = 'http://www.openlibrary.org'

    protected

    # Perform an API request
    #
    # path  - Request path
    #
    def request(path)
      url = "#{API_URL}#{path}"

      resp = RestClient.get(url) do |response, request, result, &block|
        case response.code
        when 200
          response.return!(request, result, &block)
        when 401
          raise Openlibrary::Unauthorized
        when 404
          raise Openlibrary::NotFound
        end
      end
      parse(resp)
    end

    def parse(resp)
      object = JSON.parse(resp.body)
      object
    end
  end
end
