# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'torquebox-message-encodings/version'

Gem::Specification.new do |gem|
  gem.name          = "torquebox-message-encodings"
  gem.version       = Torquebox::Message::Encodings::VERSION
  gem.authors       = ["Kevin Olbrich"]
  gem.email         = ["kevin.olbrich@gmail.com"]
  gem.description   = %q{Provides additional message serialization formats for torquebox}
  gem.summary       = %q{Provides additional message serialization formats for torquebox}
  gem.homepage      = "https://github.com/olbrich/torquebox-message-encodings"

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]
  gem.add_runtime_dependency "torquebox-messaging", "~> 2.0"
  gem.add_development_dependency "rspec"
  gem.add_development_dependency "bson"
  gem.add_development_dependency "msgpack-jruby"
end
