# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'rails_zen/version'

Gem::Specification.new do |spec|
  spec.name          = "rails_zen"
  spec.version       = RailsZen::VERSION
  spec.authors       = ["Vysakh Sreenivasan"]
  spec.email         = ["diplomatv@gmail.com"]
  spec.summary       = %q{Interactive rails generator .}
  spec.description   = %q{Create boilerplate validation in models, specs, migrations.}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.7"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.2"
end
