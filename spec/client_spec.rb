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
      book.contributors.should be_a Array
      book.covers.should be_a       Array
      book.works.should be_a        Array

      book.title.should eq                    'The Great Gatsby'
      book.by_statement.should eq             'F. Scott Fitzgerald.'
      book.number_of_pages.should eq          180
      book.contributors[0].name.should eq     'Francis Cugat'
      book.contributors[0].role.should eq     'Cover Art'
      book.copyright_date.should eq           '1925'
      book.isbn_10[0].should eq               '0743273567'
      book.identifiers.goodreads[0].should eq '4671'
      book.identifiers.google[0].should eq    'iXn5U2IzVH0C'
      book.physical_format.should eq          'Trade Paperback'
      book.publishers[0].should eq            'Scribner'

      # Because of a conflict with the internal `key?` method of 
      # Hashie::Mash, any key actually named 'key' must be referenced 
      # with a bang (!) to get the value.
      book.key!.should eq                     '/books/OL23109860M'
      book.languages[0].key!.should eq           '/languages/eng'
    end
  end

  describe '#book_by_isbn' do
    before do
      isbn_10 = '046503912X'
      type = '/type/edition'
      stub_get("/query.json?type=#{type}&isbn_10=#{isbn_10}", 
               'book_by_isbn.json')
    end
    it 'returns array of books' do
      expect { client.book_by_isbn('046503912X').not_to raise_error }

      books = client.book_by_isbn('046503912X')

      books.should be_a Array 
      books[0].should be_a Hash
    end
  end

  describe '#book_by_lccn' do
    before do
      lccn = '00271772'
      type = '/type/edition'
      stub_get("/query.json?type=#{type}&lccn=#{lccn}",
               'book_by_lccn.json')
    end
    it 'returns array of books' do
      expect { client.book_by_lccn('00271772').not_to raise_error }

      books = client.book_by_lccn('00271772')

      books.should be_a Array
      books[0].should be_a Hash
    end
  end

  describe '#book_by_oclc' do
    before do
      oclc = '42860053'
      type = '/type/edition'
      stub_get("/query.json?type=#{type}&oclc_numbers=#{42860053}",
               'book_by_oclc.json')
    end
    it 'returns array of books' do
      expect { client.book_by_oclc('42860053').not_to rasie_error }

      books = client.book_by_oclc('42860053')

      books.should be_a Array
      books[0].should be_a Hash
    end
  end

  describe '#author' do
    before do
      key = 'OL1A'
      stub_get("/authors/#{key}", 'author.json')
    end

    it 'returns author details' do
      expect { client.author('OL1A') }.not_to raise_error
      
      author = client.author('OL1A')

      author.should be_a Hashie::Mash
      author.name.should eq                'Sachi Rautroy'
      author.personal_name.should eq       'Sachi Rautroy'
      author.death_date.should eq          '2004'
      author.birth_date.should eq          '1916'
      author.last_modified.type.should eq  '/type/datetime'
      author.last_modified.value.should eq '2008-11-16T07:25:54.131674'
      author.id.should eq                  97
      author.revision.should eq            6

      # Because of a conflict with the internal `key?` method of 
      # Hashie::Mash, any key actually named 'key' must be referenced 
      # with a bang (!) to get the value.
      author.key!.should eq                '/authors/OL1A'
    end
  end
end
