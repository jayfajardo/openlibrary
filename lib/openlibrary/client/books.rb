module Openlibrary
  module Books
    # Find books in Open Library by ISBN, OLID, LCCN, or OCLC
    #
    def book(olid)
      data = request("/books/#{olid}")
      Hashie::Mash.new(data)
    end
  end
end
