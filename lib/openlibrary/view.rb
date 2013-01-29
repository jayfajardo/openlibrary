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
      type_for_uri = URI.encode_www_form_component(type)
      key_for_uri = URI.encode_www_form_component(key)

      response = RestClient.get "http://openlibrary.org/api/books" +
        "?bibkeys=#{type_for_uri}:#{key_for_uri}&format=json&jscmd=viewapi"
      response_data = JSON.parse(response)
      view = response_data["#{type}:#{key}"]

      if view 
        view_meta = new  

        view_meta.bib_key = view["bib_key"] 
        view_meta.info_url = view["info_url"]
        view_meta.preview = view["preview"]
        view_meta.preview_url = view["preview_url"]
        view_meta.thumbnail_url = view["thumbnail_url"]
        
        view_meta
      else
        nil
      end    
    end
  end

end
