require_relative 'openlibrary/version'
require_relative 'openlibrary/data'
require_relative 'openlibrary/view'
require_relative 'openlibrary/client'
require_relative 'openlibrary/errors'
require_relative 'openlibrary/request'

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
