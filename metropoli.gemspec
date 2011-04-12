# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "metropoli/version"

Gem::Specification.new do |s|
  s.name        = "metropoli"
  s.version     = Metropoli::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Adrián Cuadros"]
  s.email       = %w(adrian@innku.com)
  s.homepage    = "http://github.com/adriancuadros/metropoli"
  s.summary     = %Q{City database engine for rails 3}
  s.description = %Q{With this engine you can generate a flexible and unobstrusive city database engine that you can relate to your rails 3 models}

  s.rubyforge_project = "metropoli"

  s.add_development_dependency 'shoulda'
  s.add_development_dependency 'bundler'
  s.add_development_dependency 'rails', '~> 3.0.5'
  s.add_development_dependency 'sqlite3-ruby'

  s.add_dependency 'sinatra', '~> 1.2.0'
  s.add_dependency 'json', '~> 1.5.1'

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]
end

