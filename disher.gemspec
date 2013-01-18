# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'disher/version'

Gem::Specification.new do |gem|
  gem.name          = "disher"
  gem.version       = Disher::VERSION
  gem.authors       = ["Satoshi Ebisawa"]
  gem.email         = ["e.satoshi@gmail.com"]
  gem.description   = %q{Extract main content from a web page.}
  gem.summary       = %q{Extract main content from a web page.}
  gem.homepage      = "https://github.com/satococoa/disher"

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]

  gem.add_dependency('nokogiri')
  gem.add_development_dependency('rspec')
end
