require 'spec_helper'

describe 'Client' do
  let(:client)  { Openlibrary::Client.new(username: 'doe', 
                                          password: 'fake') }
  before(:each) { Openlibrary.reset_configuration }

  describe '#new' do
    it 'requires an argument' do
      expect { Openlibrary::Client.new(nil) }.
        to raise_error ArgumentError, "Options hash required."
    end

    it 'requires a hash argument' do
      expect { Openlibrary::Client.new('foo') }.
        to raise_error ArgumentError, "Options hash required."
    end
  end

  describe '#book' do
    before { stub_get('/book/show', {olid: 'OL23109860M'}, 'book.json') }
    it 'returns a book by its OLID' do
      expect { client.book('OL23109860M') }.not_to raise_error
    end
  end
end
