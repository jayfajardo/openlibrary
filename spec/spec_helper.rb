require 'rspec'
require 'openlibrary'
require 'rest-client'
require 'webmock'
require 'webmock/rspec'

RSpec.configure do |config|
  config.color_enabled = true
  config.formatter     = 'documentation'
end

def stub_get(path, params, fixture_name)
  params[:format] = 'json'
  stub_request(:get, api_url(path)).
    with(:query => params).
    to_return(
      :status => 200,
      :body => fixture(fixture_name)
    )
end

def fixture_path(file=nil)
  path = File.expand_path("../fixtures", __FILE__)
  file.nil ? path : File.join(path, file)
end

def fixture(file)
  File.read(fixture_path(file))
end

def api_url(path)
  "#{Openlibrary::Request::API_URL}#{path}"
end
