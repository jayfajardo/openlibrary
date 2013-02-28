module Openlibrary
  class Books
    # Find books in Open Library by ISBN, OLID, LCCN, or OCLC
    #
    def book(olid)
      data = request("/books/#{olid}.json")
      Hashie::Mash.new(data)
    end
  end
end
