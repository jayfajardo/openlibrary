# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "openlibrary/version"

Gem::Specification.new do |s|
  s.name        = "openlibrary"
  s.version     = Openlibrary::VERSION
  s.authors     = ["Jay Fajardo"]
  s.email       = ["jmrfajardo@gmail.com"]
  s.homepage    = "http://www.proudcloud.net"
  s.summary     = %q{Ruby Interface for the OpenLibrary API}
  s.description = %q{OpenLibrary API Interface}

  s.rubyforge_project = "openlibrary"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  # specify any dependencies here; for example:
  s.add_development_dependency "rspec"
  s.add_runtime_dependency "json"
  s.add_runtime_dependency "rest-client"
end
