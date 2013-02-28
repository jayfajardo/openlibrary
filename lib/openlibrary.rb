require 'openlibrary/version'
require 'json'
require 'rest-client'
require 'uri'
autoload :Data, 'openlibrary/data'
autoload :View, 'openlibrary/view'
autoload :Client, 'openlibrary/client'

module Openlibrary

  # Create a new Openlibrary::Client instance
  # 
  def self.new(options={})
    Openlibrary::Client.new(options)
  end

  # Return the openlibrary gem version
  #
  def self.version_string
    "Openlibrary version #{Openlibrary::VERSION}"
  end

end
