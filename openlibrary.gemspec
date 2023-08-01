# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "openlibrary/version"

Gem::Specification.new do |s|
  s.name = "openlibrary"
  s.version = Openlibrary::VERSION
  s.authors = ["Jay Fajardo"]
  s.email = ["jmrfajardo@gmail.com"]
  s.homepage = "http://www.proudcloud.net"
  s.summary = %q{Ruby Interface for the Openlibrary.org API}
  s.description = %q{Openlibrary.org API Interface}
  s.licenses = ['CC0-1.0']

  s.files = `git ls-files`.split("\n")
  s.test_files = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  s.add_development_dependency 'rspec', '~> 3.6'
  s.add_development_dependency 'webmock', '~> 3'

  s.add_runtime_dependency 'json',  '~> 2.5', '>= 2.5.1'
  s.add_runtime_dependency 'rest-client', '~> 2.0', '~> 2.0.1'
  s.add_runtime_dependency 'hashie', '~> 2.0', '~> 2.0.2'

  s.add_runtime_dependency 'activesupport', '>= 6'
end
