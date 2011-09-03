module Openlibrary

  class Data 
    attr_accessor :url
    attr_accessor :title
    attr_accessor :subtitle
    attr_accessor :authors
    attr_accessor :identifiers
    attr_accessor :classifications
    attr_accessor :subjects, :subject_places, :subject_people, :subject_times
    attr_accessor :publishers, :publish_places
    attr_accessor :date_published
    attr_accessor :excerpts
    attr_accessor :links
    attr_accessor :cover
    attr_accessor :ebooks
    attr_accessor :pages
    attr_accessor :weight

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
      response = RestClient.get "http://openlibrary.org/api/books?bibkeys=#{type}:#{key}&format=json&jscmd=data"

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
        puts "OPENLIBRARY: Using #{type} with #{key}, not found on Openlibrary.org"
        nil
      end    
    end
  end


end

