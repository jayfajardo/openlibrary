module Openlibrary
  class Error         < StandardError; end
  class Unauthorized  < Error; end
  class NotFound      < Error; end
end
