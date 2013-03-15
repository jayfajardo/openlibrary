module Openlibrary
  module Save
    # Save changes to Open Library
    #
    def save(key, cookie, changes, comment="")
      response = put("#{key}", "#{cookie}", "#{changes}", "#{comment}")
      Hashie::Mash.new(response)
    end
  end
end
