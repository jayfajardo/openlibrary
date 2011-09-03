module Openlibrary

  class Details
    attr_accessor :bib_key
    attr_accessor :info_url
    attr_accessor :preview
    attr_accessor :preview_url
    attr_accessor :thumbnail_url

    def self.search(key)
      response = RestClient.get "http://openlibrary.org/api/books?bibkeys=ISBN:#{key}&format=json&jscmd=viewapi"

        response_data = JSON.parse(response)
        view = response_data["ISBN:#{key}"]
      if book 
        view_meta = new  

        view_meta.bib_key = book["bib_key"] 
        view_meta.info_url = book["info_url"]
        view_meta.preview = book["preview"]
        view_meta.preview_url = book["preview_url"]
        view_meta.thumbnail_url = book["thumbnail_url"]
        
        #for debugging purposes
        #puts view_meta

        view_meta
      else
        puts "OPENLIBRARY: #{key} was not found on Openlibrary.org"
        nil
      end    
    end
  end


end

