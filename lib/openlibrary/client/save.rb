module Openlibrary
  module Save
    # Save changes to Open Library
    # 
    # key     - Open Library object key
    # cookie  - Cookie retrieved by login method
    # update  - Full Open Library JSON object with updated keys/values
    # comment - String comment describing the changes
    #
    def save(key, cookie, update, comment)
      response = update("#{key}", "#{cookie}", "#{update}", "#{comment}")
      Hashie::Mash.new(response)
    end
  end
end
