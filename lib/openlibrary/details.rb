module Openlibrary

  class Details 
    attr_accessor :info_url
    attr_accessor :bib_key
    attr_accessor :preview_url
    attr_accessor :thumbnail_url
    attr_accessor :details

    def self.find_by_isbn(key)
      find("ISBN",key)
    end

    def self.find_by_lccn(key)
      find("LCCN",key)
    end

    def self.find_by_oclc(key)
      find("OCLC",key)
    end

    def self.find_by_olid(key)
      find("OLID",key)
    end

    def self.find(type,key)
      type_for_uri = URI.encode_www_form_component(type)
      key_for_uri = URI.encode_www_form_component(key)

      response = RestClient.get "http://openlibrary.org/api/books" +
        "?bibkeys=#{type_for_uri}:#{key_for_uri}&format=json&jscmd=data"
      response_data = JSON.parse(response)
      book = response_data["#{type}:#{key}"]

      if book 
        book_meta = new  

        book_meta.info_url = book["info_url"]
        book_meta.bib_key = book["bib_key"]
        book_meta.preview_url = book["preview_url"]
        book_meta.thumbnail_url = book["thumbnail_url"]
        book_meta.details = book["details"]
        
        book_meta
      else
        nil
      end    
    end
  end


end

