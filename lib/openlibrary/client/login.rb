module Openlibrary
  module Login
    # Log in to Open Library
    #
    def login(username, password)
      session = protected_login("#{username}", "#{password}")
    end
  end
end
