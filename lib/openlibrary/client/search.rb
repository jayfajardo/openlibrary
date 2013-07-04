module Openlibrary
  module Search
    # Access the Openlibrary free-text search.
    # This API is experimental but useful (http://openlibrary.org/dev/docs/api/search)
    # This implementation only supports the first 100 results for simplicity

    # Possible search parameter keys include
    # :q (cross-field query)
    # :author
    # :publisher
    # :isbn
    # :title
    # :person
    # :place
    # :subject
    def search(search_params, limit=10, offset=0)
      processed_params = search_params.is_a?(String) ? {q: search_params} : search_params
      data = request("/search.json", params: processed_params)
      results = []
      data["docs"][offset...offset+limit].each do |result|
        results << Hashie::Mash.new(result)
      end
      results
    end

  end
end