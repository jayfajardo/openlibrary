require 'rest-client'
require 'active_support'
require 'active_support/core_ext'
require 'json'
require 'uri'
require 'hashie'

module Openlibrary
  module Request
    API_URL    = 'https://openlibrary.org'

    protected

    HANDLE_REST_CLIENT_RESPONSE = lambda do |response, request, result, &block|
      case response.code
      when 200
        response.return!(request, result, &block)
      when 401
        raise Openlibrary::Unauthorized
      when 404
        raise Openlibrary::NotFound
      when 302
        raise Openlibrary::Redirect
      end
    end

    # Perform a GET request
    #
    # path   - Request path
    #
    def request(path, params={})
      request_url = "#{API_URL}#{path}"
      perform_get_request(request_url, params)
    end


    # Get the history of an object in Open Library
    #
    # object   - Object key, e.g., '/books/OL1M'
    #
    def history(object, params={})
      history_url = "#{API_URL}#{object}.json?m=history"
      perform_get_request(history_url, params)
    end

    # Perform a query using the Query API
    #
    # query - Query path, e.g. "type=/type/edition&isbn_10=XXXXXXXXXX"
    #
    def query(query, params={})
      query_url = "#{API_URL}/query.json?#{query}"
      perform_get_request(query_url, params)
    end

    def protected_login(username, password, params={})
      params.merge!(content_type: :json, accept: :json)
      url   = "#{API_URL}/account/login"
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
        when 302
          raise Openlibrary::Redirect
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
      update_url = "#{API_URL}#{key}"

      response = RestClient.put(update_url, update, params, &HANDLE_REST_CLIENT_RESPONSE)
      parse(response)
    end

    def parse(response)
      JSON.parse(response.body)
    end
    private :parse

    def perform_get_request(url, params)
      params.merge!(accept: :json)
      response = RestClient.get(url, params, &HANDLE_REST_CLIENT_RESPONSE)
      parse(response)
    end
    private :perform_get_request
  end
end
