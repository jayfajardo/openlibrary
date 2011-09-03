module Openlibrary

  class Data 
    attr_accessor :bib_key
    attr_accessor :info_url
    attr_accessor :preview
    attr_accessor :preview_url
    attr_accessor :thumbnail_utl


    def self.search(key)
      response = RestClient.get "http://openlibrary.org/api/books?bibkeys=ISBN:#{key}&format=json&jscmd=viewapi"

        response_data = JSON.parse(response)
        book = response_data["ISBN:#{key}"]
      if book 
        book_meta = new  

        book_meta.title = book["title"] 
        book_meta.subtitle = book["subtitle"]
        book_meta.authors = book["authors"]
        book_meta.identifiers = book["identifiers"]
        book_meta.classifications = book["classifications"]
        book_meta.subjects = book["subjects"]
        book_meta.subject_places = book["subject_places"]
        book_meta.subject_people = book["subject_people"]
        book_meta.publishers = book["publishers"]
        book_meta.publish_places = book["publish_places"]
        book_meta.date_published = book["date_published"]
        book_meta.excerpts = book["excerpts"]
        book_meta.links = book["links"]
        book_meta.cover = book["cover"]
        book_meta.ebooks = book["ebooks"]
        book_meta.pages = book["pages"]
        book_meta.weight = book["weight"]
        
        #for debugging purposes
        #puts book_meta

        book_meta
      else
        puts "OPENLIBRARY: #{key} was not found on Openlibrary.org"
        nil
      end    
    end
  end


end

