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

    # Initialize an Openlibrary::Client instance
    #
    def initialize(options={})
      unless options.kind_of?(Hash)
        raise ArgumentError, "Options hash required."
      end
    end
  end
end
