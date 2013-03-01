require 'openlibrary/request'
require 'openlibrary/client/books'

module Openlibrary
  class Client
    include Openlibrary::Request
    include Openlibrary::Books

    attr_reader :username, :password

    # Initialize an Openlibrary::Client instance
    #
    # options[:username]  - Username
    # options[:password]  - Password
    #
    def initialize(options={})
      unless options.kind_of?(Hash)
        raise ArgumentError, "Options hash required."
      end

      # For future versions that include the ability to log in
      # 
      #  @username = options[:username] || Openlibrary.configuration[:username]
      #  @password = options[:password] || Openlibrary.configuration[:password]
    end
  end
end
