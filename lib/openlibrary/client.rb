require_relative 'request'
require_relative 'client/books'
require_relative 'client/authors'
require_relative 'client/history'
require_relative 'client/recent'
require_relative 'client/editions'
require_relative 'client/search'
require_relative 'client/login'
require_relative 'client/save'

module Openlibrary
  class Client
    include Openlibrary::Request
    include Openlibrary::Books
    include Openlibrary::Authors
    include Openlibrary::History
    include Openlibrary::Recent
    include Openlibrary::Editions
    include Openlibrary::Search
    include Openlibrary::Login
    include Openlibrary::Save

    attr_reader :custom_headers

    # Initialize an Openlibrary::Client instance
    #
    # options - Hash of options (optional)
    #   :headers - Hash of custom headers to include in all requests
    #              e.g., { 'User-Agent' => 'MyApp/1.0 (contact@example.com)' }
    #
    def initialize(options={})
      unless options.kind_of?(Hash)
        raise ArgumentError, "Options hash required."
      end
      @custom_headers = options[:headers] || {}
    end
  end
end
