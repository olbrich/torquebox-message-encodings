# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'torquebox-message-formats/version'

Gem::Specification.new do |gem|
  gem.name          = "torquebox-message-formats"
  gem.version       = Torquebox::Message::Formats::VERSION
  gem.authors       = ["Kevin Olbrich"]
  gem.email         = ["kolbrich@6fusion.com"]
  gem.description   = %q{TODO: Provides additional message serialization formats for torquebox}
  gem.summary       = %q{TODO: Provides additional message serialization formats for torquebox}
  gem.homepage      = ""

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]
  gem.add_runtime_dependency "torquebox-messaging", "~> 2.0"
end
