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
    # params - Parameters hash
    #
    def request(path, params={})
      username = username || Openlibrary.configuration[:username]
      password = password || Openlibrary.configuration[:password]

      params.merge!( accept: :json, username: username, password: password)

      url = "#{API_URL}#{path}"

      resp = RestClient.get(url, params: params) do |response, request, result, &block|
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
