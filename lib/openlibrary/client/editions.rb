module Openlibrary
  module Editions
    # Get the editions of a work
    #
    def editions(work, limit=10, offset=0)
      data = request("/works/#{work}/editions.json?limit=#{limit}&offset=#{offset}")
      editions = Hashie::Mash.new(data)
    end
  end
end
