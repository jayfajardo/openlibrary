module Openlibrary
  module Save
    # Save changes to Open Library
    # 
    # key     - Open Library object key
    # cookie  - Cookie retrieved by login method
    # update  - Complete, updated Open Library JSON object
    # comment - String comment describing the changes
    #
    # Note that 'update' can reference an external JSON file or 
    # a properly formatted Ruby object.
    #
    def save(key, cookie, update, comment)
      response = update("#{key}", "#{cookie}", "#{update}", "#{comment}")
      Hashie::Mash.new(response)
    end
  end
end
