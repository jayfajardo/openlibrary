module Openlibrary

  class View 
    attr_accessor :bib_key
    attr_accessor :info_url
    attr_accessor :preview
    attr_accessor :preview_url
    attr_accessor :thumbnail_url

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
      response = RestClient.get "http://openlibrary.org/api/books?bibkeys=#{type}:#{key}&format=json&jscmd=viewapi"

      response_data = JSON.parse(response)
      view = response_data["#{type}:#{key}"]
      if view 
        view_meta = new  

        view_meta.bib_key = view["bib_key"] 
        view_meta.info_url = view["info_url"]
        view_meta.preview = view["preview"]
        view_meta.preview_url = view["preview_url"]
        view_meta.thumbnail_url = view["thumbnail_url"]
        
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

