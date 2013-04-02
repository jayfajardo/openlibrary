require 'rest-client'
require 'active_support/core_ext'
require 'json'
require 'uri'
require 'hashie'

module Openlibrary
  module Request
    API_URL    = 'http://www.openlibrary.org'

    protected

    # Perform a GET request
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
    # object   - Object key, e.g., '/books/OL1M'
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
    # query - Query path, e.g. "type=/type/edition&isbn_10=XXXXXXXXXX"
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

    def protected_login(username, password, params={})
      params.merge!(content_type: :json, accept: :json)
      url = "#{API_URL}/account/login"
      login = { 'username' => username, 'password' => password }.to_json

      resp = RestClient.post(url, login, params) do |response|
        case response.code
        when 200
          session = response.cookies
          session
        when 401
          raise Openlibrary::Unauthorized
        when 404
          raise Openlibrary::NotFound
        end
      end
    end

    # Update an Open Library object 
    #
    # key     - Object key the Open Library resource
    # cookie  - Cookie retrieved by the login method
    # update  - Complete updated Open Library object in JSON format
    # comment - Comment describing the change(s) to the object
    #
    def update(key, cookie, update, comment, params={})
      cookie_header = { 'Cookie' => cookie }
      comment_header = { 
        'Opt' => '"http://openlibrary.org/dev/docs/api"; ns=42',
        '42-comment' => comment 
      }
      params.merge!(cookie_header)
      params.merge!(comment_header)
      params.merge!(content_type: :json, accept: :json)
      url = "#{API_URL}#{key}"

      resp = RestClient.put(url, update, params) do |response, request, result, &block|
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
