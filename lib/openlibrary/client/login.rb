module Openlibrary
  module Login
    # Log in to Open Library
    #
    def login(username, password)
      response = protected_login("#{username}", "#{password}")
      cookie = Hashie::Mash.new(response).session
    end
  end
end
