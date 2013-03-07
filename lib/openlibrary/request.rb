require 'rest-client'
require 'active_support/core_ext'
require 'json'
require 'uri'
require 'hashie'

module Openlibrary
  module Request
    API_URL    = 'http://www.openlibrary.org'

    protected

    # Perform an API request
    #
    # path   - Request path
    #
    def request(path, params={})
      params.merge!(accept: :json)
      url = "#{API_URL}#{path}"

      resp = RestClient.get(url, params) do |response, request, result, &block|
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

    # Get the history of an object in Open Library
    # 
    # object   - object key, e.g., '/books/OL1M'
    #
    def history(object, params={})
      params.merge!(accept: :json)
      url = "#{API_URL}#{object}.json?m=history"

      resp = RestClient.get(url, params) do |response, request, result, &block|
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

    # Perform a query using the Query API
    #
    # path   - Request path
    #
    def query(query, params={})
      params.merge!(accept: :json)
      url = "#{API_URL}/query.json?#{query}"

      resp = RestClient.get(url, params) do |response, request, result, &block|
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

    def login(username, password, params={})
      params.merge!(:content_type: :json, accept: :json)
      url = "#{API_URL}/account/login"
      login = { 'username': username, 'password': password }.to_json

      resp = RestClient.post(url, login, params) do |response, request, result, &block|
        case response.code
        when 200
          resp.return!(request, result, &block)
        when 401
          raise Openlibrary::Unauthorized
        when 404
          raise Openlibrary::NotFound
        end
        session = resp.cookies
        session
      end
    end

    def parse(resp)
      object = JSON.parse(resp.body)
      object
    end
  end
end
