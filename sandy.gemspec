# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'sandy/version'

Gem::Specification.new do |gem|
  gem.name          = "sandy"
  gem.version       = Sandy::VERSION
  gem.authors       = ["Cameron Cundiff"]
  gem.email         = ["ckundo@gmail.com"]
  gem.description   = %q{TODO: Write a gem description}
  gem.summary       = %q{TODO: Write a gem summary}
  gem.homepage      = ""

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]

  gem.add_dependency("httparty", "~> 0.9.0")
  gem.add_development_dependency("rake")                                                                
  gem.add_development_dependency("rspec", "~> 2.11.0")
  gem.add_development_dependency("webmock", "~> 1.8.11")
  gem.add_development_dependency("vcr", "~> 2.3.0")
end
