module Openlibrary
  module History
    # Get the revision history of an object in Open Library
    #
    def rev_history(object_key)
      data = history("#{object_key}")
    end
  end
end
