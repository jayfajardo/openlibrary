require 'openlibrary/version'
require 'openlibrary/data'
require 'openlibrary/view'
require 'openlibrary/client'
require 'openlibrary/errors'
require 'openlibrary/request'

module Openlibrary
  # Create a new Openlibrary::Client instance
  # 
  def self.new(options={})
    Openlibrary::Client.new(options)
  end

  # Return the openlibrary gem version
  #
  def self.version
    "Openlibrary version #{Openlibrary::VERSION}"
  end
end
