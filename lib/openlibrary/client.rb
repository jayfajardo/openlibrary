module Openlibrary
  class Client
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

      @username = options[:username]
      @password = options[:password]
    end
  end
end
