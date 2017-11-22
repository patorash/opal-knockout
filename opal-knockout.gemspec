# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'opal/knockout/version'

Gem::Specification.new do |spec|
  spec.name          = "opal-knockout"
  spec.version       = Opal::Knockout::VERSION
  spec.authors       = ["patorash"]
  spec.email         = ["chariderpato@gmail.com"]
  spec.summary       = %q{Opal library for knockout.js}
  spec.description   = %q{Opal library for knockout.js}
  spec.homepage      = "https://github.com/patorash/opal-knockout"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.15"
  spec.add_runtime_dependency 'opal', '~> 0.10.5'
  spec.add_runtime_dependency 'opal-activesupport', '~> 0.1.0'
  spec.add_development_dependency 'opal-jquery', '~> 0.4.2'
  spec.add_development_dependency 'opal-rspec', '~> 0.6.1'
  spec.add_development_dependency 'yard'
  spec.add_development_dependency 'rake'
end
