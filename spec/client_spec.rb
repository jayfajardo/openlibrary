require 'spec_helper'

describe 'Client' do
  let(:client)  { Openlibrary::Client.new }

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

      expect(book).to be_a Hashie::Mash
      expect(book.contributors).to be_a Array
      expect(book.covers).to be_a       Array
      expect(book.works).to be_a        Array

      expect(book.title).to eq                    'The Great Gatsby'
      expect(book.by_statement).to eq             'F. Scott Fitzgerald.'
      expect(book.number_of_pages).to eq          180
      expect(book.contributors[0].name).to eq     'Francis Cugat'
      expect(book.contributors[0].role).to eq     'Cover Art'
      expect(book.copyright_date).to eq           '1925'
      expect(book.isbn_10[0]).to eq               '0743273567'
      expect(book.identifiers.goodreads[0]).to eq '4671'
      expect(book.identifiers.google[0]).to eq    'iXn5U2IzVH0C'
      expect(book.physical_format).to eq          'Trade Paperback'
      expect(book.publishers[0]).to eq            'Scribner'
      expect(book.subjects[1]).to eq              'First loves -- Fiction'
      expect(book.subjects[0]).to eq              'Traffic accidents -- Fiction'

      # Because of a conflict with the internal `key?` method of
      # Hashie::Mash, any key actually named 'key' must be referenced
      # with a bang (!) to get the value.
      expect(book.key!).to eq                     '/books/OL23109860M'
      expect(book.languages[0].key!).to eq           '/languages/eng'
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
      expect { client.book_by_isbn('123').
        to raise_error ArgumentError, "ISBN must be 10 or 13 characters." }

      books = client.book_by_isbn('046503912X')

      expect(books).to be_a Array
      expect(books[0]).to be_a Hash

      expect(books[0]['key']).to eq '/books/OL6807502M'
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

      expect(books).to be_a Array
      expect(books[0]).to be_a Hash
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
      expect { client.book_by_oclc('42860053').not_to raise_error }

      books = client.book_by_oclc('42860053')

      expect(books).to be_a Array
      expect(books[0]).to be_a Hash
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

      expect(author).to be_a Hashie::Mash
      expect(author.name).to eq                'Sachi Rautroy'
      expect(author.personal_name).to eq       'Sachi Rautroy'
      expect(author.death_date).to eq          '2004'
      expect(author.birth_date).to eq          '1916'
      expect(author.last_modified.type).to eq  '/type/datetime'
      expect(author.last_modified.value).to eq '2008-11-16T07:25:54.131674'
      expect(author.id).to eq                  97
      expect(author.revision).to eq            6

      # Because of a conflict with the internal `key?` method of
      # Hashie::Mash, any key actually named 'key' must be referenced
      # with a bang (!) to get the value.
      expect(author.key!).to eq                '/authors/OL1A'
    end
  end

  describe '#rev_history' do
    before do
      key = '/books/OL1M'
      stub_get("#{key}.json?m=history", 'history.json')
    end

    it 'returns the revision history of an object' do
      expect { client.rev_history('/books/OL1M') }.not_to raise_error

      history = client.rev_history('/books/OL1M')

      expect(history).to be_a Array
      expect(history[0]).to be_a Hash
    end
  end

  describe '#recent' do
    before do
      stub_get("/recentchanges", 'recent.json')
    end

    it 'returns recent changes to Open Library' do
      expect { client.recent.not_to raise_error }

      changes = client.recent

      expect(changes).to be_a Array
      expect(changes[0]).to be_a Hash
    end
  end

  describe '#editions' do
    before do
      work = 'OL27258W'
      stub_get("/works/#{work}/editions.json?limit=10&offset=0", 'editions.json')
    end

    it 'returns the editions of a work' do
      expect { client.editions('OL27258W') }.not_to raise_error

      editions = client.editions('OL27258W', 10, 0)

      expect(editions).to be_a Hashie::Mash
      expect(editions.entries).to be_a Array

      expect(editions.size!).to eq      19
      expect(editions.links.next).to eq '/works/OL27258W/editions.json?limit=10&offset=10'
      expect(editions.links.self).to eq '/works/OL27258W/editions.json?limit=10&offset=0'
      expect(editions.links.work).to eq '/works/OL27258W'

      # Failing tests for iteration through entries
      #
      # editions.entries[0].should be_a Hashie::Mash
      # editions.entries[0].number_of_pages.should eq 322
    end
  end

  describe '#search' do
    before do
      stub_get("/search.json?author=tolkien&title=lord%20of%20the%20rings", 'search.json')
      stub_get("/search.json?q=capitalism%20and%20freedom", 'free_search.json')
    end

    it 'returns book search results' do
      search = {title: "lord of the rings", author: "tolkien"}
      expect {client.search(search)}.not_to raise_error

      search = client.search(search, 5, 10)

      expect(search.size).to eq         5
      expect(search[0].key!).to eq   'OL14926051W'
      expect(search[0].title).to eq  'The Lord of Rings'

      expect {client.search("capitalism and freedom")}.not_to raise_error
      free_search = client.search("capitalism and freedom")

      expect(free_search.size).to eq                10
      expect(free_search[0].key!).to eq             'OL2747782W'
      expect(free_search[0].author_name[0]).to eq   'Milton Friedman'
    end
  end

  describe '#login' do
    before do
      stub_http_request(:post, "https://openlibrary.org/account/login").
        with( body: "{\"username\":\"username\",\"password\":\"password\"}" ).
        to_return( status: 200, headers: {'Set-Cookie' => 'session=cookie'} )
    end

    it 'logs in to Open Library' do
      expect { client.login('username', 'password') }.not_to raise_error

      cookie = client.login('username', 'password')
      expect(cookie).to eq "cookie"
    end
  end

  describe '#after_save' do
    before do
      key = "/books/OL9674499M"
      comment = 'update weight and number of pages'
      stub_put(key, 'save_after_change.json', comment)
    end

    it 'PUTs the updated object, and receives the updated object as a response' do
      key = "/books/OL9674499M"
      cookie = 'cookie'
      update = fixture('save_after_change.json')
      comment = 'update weight and number of pages'

      expect { client.save(key, cookie, update, comment) }.not_to raise_error

      object = client.save(key, cookie, update, comment)

      expect(object.weight).to eq '1.5 pounds'
      expect(object.number_of_pages).to eq 1103
    end
  end
end
