require 'spec_helper'

describe 'Client' do
  let(:client)  { Openlibrary::Client.new() }

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
    before do
      olid = 'OL23109860M'
      stub_get("/books/#{olid}", 'book.json')
    end
    it 'returns book details' do
      expect { client.book('OL23109860M') }.not_to raise_error

      book = client.book('OL23109860M')

      book.should be_a Hashie::Mash
      book.contributors.should be_a        Array
      book.covers.should be_a              Array

      book.title.should eq                 'The Great Gatsby'
      book.by_statement.should eq          'F. Scott Fitzgerald.'
      book.number_of_pages.should eq       180
      book.contributors[0].name.should eq  'Francis Cugat'
      book.contributors[0].role.should eq  'Cover Art'
      book.copyright_date.should eq        '1925'
    end
  end
end
