# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'spec_requirer/version'

Gem::Specification.new do |spec|
  spec.name          = "spec_requirer"
  spec.version       = SpecRequirer::VERSION
  spec.authors       = ["Kris Leech"]
  spec.email         = ["kleech@housetrip.com"]
  spec.summary       = 'Explicitly require files and manage LOAD_PATH in tests which do not boot a framework'
  spec.description   = 'Explicitly require files and manage LOAD_PATH in tests which do not boot a framework'
  spec.homepage      = "https://github.com/krisleech/spec_requirer"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.6"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec"
end
