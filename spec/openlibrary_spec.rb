require 'spec_helper'

describe Openlibrary do
  it 'should return correct version string' do
    Openlibrary.version_string.should == "Openlibrary version #{Openlibrary::VERSION}"
  end
end

