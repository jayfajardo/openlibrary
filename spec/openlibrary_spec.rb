require 'spec_helper'

describe 'Openlibrary' do
  it 'should return correct version string' do
    Openlibrary.version.should == "Openlibrary version #{Openlibrary::VERSION}"
  end
end

describe 'Openlibrary::View' do
	before do
		@book_view = Openlibrary::View.new
	end

	subject { @book_view }

	it { should_not respond_to(:some_random_thing) }

	it { should respond_to(:bib_key) }
	it { should respond_to(:info_url) }
	it { should respond_to(:preview) }
	it { should respond_to(:preview_url) }
	it { should respond_to(:thumbnail_url) }
end

describe 'Openlibrary::Data' do
	before do
		@book_data = Openlibrary::Data.new
	end

	subject { @book_data }
	
	it { should_not respond_to(:some_random_thing) }

	it { should respond_to(:url) }
	it { should respond_to(:title) }
	it { should respond_to(:subtitle) }
	it { should respond_to(:authors) }
	it { should respond_to(:identifiers) }
	it { should respond_to(:classifications) }
	it { should respond_to(:subjects) }
	it { should respond_to(:subject_places) }
	it { should respond_to(:subject_people) }
	it { should respond_to(:subject_times) }
	it { should respond_to(:publishers) }
	it { should respond_to(:publish_places) }
	it { should respond_to(:publish_date) }
	it { should respond_to(:excerpts) }
	it { should respond_to(:links) }
	it { should respond_to(:cover) }
	it { should respond_to(:ebooks) }
	it { should respond_to(:pages) }
	it { should respond_to(:weight) }
end

describe 'Openlibrary::Details' do
	before do
		@book_details = Openlibrary::Details.new
	end

	subject { @book_details }
	
	it { should_not respond_to(:some_random_thing) }

	it { should respond_to(:info_url) }
	it { should respond_to(:bib_key) }
	it { should respond_to(:preview_url) }
	it { should respond_to(:thumbnail_url) }
	it { should respond_to(:details) }
end
