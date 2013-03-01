require 'rest-client'
require 'active_support/core_ext'
require 'json'
require 'uri'

module Openlibrary
  module Request
    API_URL    = 'http://www.openlibrary.org'

    protected

    # Perform an API request
    #
    # path   - Request path
    #
    def request(path)
      # This code is for future versions that allow user login.
      # 
      # username = username || Openlibrary.configuration[:username]
      # password = password || Openlibrary.configuration[:password]

      url = "#{API_URL}#{path}.json"

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
