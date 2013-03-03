module Openlibrary
  module Books
    # Find books in Open Library by OLID, ISBN, LCCN, or OCLC
    #
    def book(olid)
      data = request("/books/#{olid}")
      Hashie::Mash.new(data)
    end

    def book_by_isbn(isbn)
      type = "/type/edition"
      if isbn.length == 10
        data = query("type=#{type}&isbn_10=#{isbn}")
      elsif isbn.length == 13
        data = query("type=#{type}&isbn_13=#{isbn}")
      end
    end

    def book_by_lccn(lccn)
      type = "/type/edition"
      data = query("type=#{type}&lccn=#{lccn}")
    end

    def book_by_oclc(oclc)
      type = "/type/edition"
      data = query("type=#{type}&oclc_numbers=#{oclc}")
    end
  end
end
