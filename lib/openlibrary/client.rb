require 'openlibrary/request'
require 'openlibrary/client/books'
require 'openlibrary/client/authors'
require 'openlibrary/client/history'
require 'openlibrary/client/recent'

module Openlibrary
  class Client
    include Openlibrary::Request
    include Openlibrary::Books
    include Openlibrary::Authors
    include Openlibrary::History
    include Openlibrary::Recent

    # Initialize an Openlibrary::Client instance
    #
    def initialize(options={})
      unless options.kind_of?(Hash)
        raise ArgumentError, "Options hash required."
      end

      # For future versions, options may include cookie information 
      # and alternative Accept headers (e.g., RDF instead of JSON)
    end
  end
end
