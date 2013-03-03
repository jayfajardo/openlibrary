module Openlibrary
  module Recent
    # Get an array of recent changes to Open Library
    #
    def recent
      data = request("/recentchanges")
    end
  end
end
