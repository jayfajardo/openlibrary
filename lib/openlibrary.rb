require "openlibrary/version"
require 'json'
require 'rest-client'
require 'uri'

module Openlibrary

  autoload :Data, 'openlibrary/data'
  autoload :View, 'openlibrary/view'

  def self.version_string
    "Openlibrary version #{Openlibrary::VERSION}"
  end


end
