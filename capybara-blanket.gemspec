# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'capybara/blanket/version'

Gem::Specification.new do |spec|
  spec.name          = "capybara-blanket"
  spec.version       = Capybara::Blanket::VERSION
  spec.authors       = ["Keyvan Fatehi", "Valentine Ionov"]
  spec.email         = ["valentine.emperor@gmail.com"]
  spec.description   = %q{Extract Blanket.js code coverage data from within a Ruby Capybara environment}
  spec.summary       = %q{Extract Blanket.js code coverage data from within a Ruby Capybara environment}
  spec.homepage      = "https://github.com/vemperor/capybara-blanket"
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_runtime_dependency "haml"
end
