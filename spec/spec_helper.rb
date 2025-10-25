$:.unshift File.expand_path("../..", __FILE__)

require 'openlibrary'
require 'rspec'
require 'rest-client'
require 'webmock'
require 'webmock/rspec'

RSpec.configure do |config|
  config.color = true
  config.formatter     = 'documentation'
end

def stub_get(path, fixture_name)
  stub_request(:get, api_url(path)).
    with(headers: {
      'Accept'=>'application/json'
    }).
    to_return(
      status:  200,
      body:    fixture(fixture_name),
      headers: {}
    )
end

def stub_put(path, fixture_name, comment)
  stub_request(:put, api_url(path)).
    with(
      body: fixture(fixture_name),
      headers: {
        'Accept'       => 'application/json',
        'Content-Type' => 'application/json',
        'Opt'          => '"http://openlibrary.org/dev/docs/api"; ns=42',
        '42-comment'   => comment,
        'Cookie'       => 'cookie'
      }).
    to_return(
      status:  200,
      body:    fixture(fixture_name),
      headers: {}
    )
end

def fixture_path(file=nil)
  path = File.expand_path("../fixtures", __FILE__)
  file.nil? ? path : File.join(path, file)
end

def fixture(file)
  File.read(fixture_path(file))
end

def api_url(path)
  "#{Openlibrary::Request::API_URL}#{path}"
end
