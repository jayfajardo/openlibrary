require 'openlibrary/version'
require 'openlibrary/data'
require 'openlibrary/view'
require 'openlibrary/client'
require 'openlibrary/errors'
require 'openlibrary/request'

module Openlibrary
  # Class variable to hold username and password configuration
  #
  @@options = {}

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

  # Define a global configuration
  #
  # options[:username]
  # options[:password]
  #
  def self.configure(options={})
    unless options.kind_of?(Hash)
      raise ArgumentError, "Options hash required."
    end

    @@options[:username] = options[:username]
    @@options[:password] = options[:password]
    @@options
  end

  ## Returns the global configuration hash
  #
  def self.configuration
    @@options
  end

  # Resets the global configuration
  #
  def self.reset_configuration
    @@options = {}
  end

end
