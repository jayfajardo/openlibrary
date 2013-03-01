require 'spec_helper'

describe 'Client' do
  let(:client)  { Openlibrary::Client.new(username: 'doe', 
                                          password: 'fake') }
  before(:each) { Openlibrary.reset_configuration }
end
