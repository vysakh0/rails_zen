# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'rails_zen/version'

Gem::Specification.new do |spec|
  spec.name          = "rails_zen"
  spec.version       = RailsZen::VERSION
  spec.authors       = ["Vysakh Sreenivasan"]
  spec.email         = ["diplomatv@gmail.com"]
  spec.summary       = %q{Interactive rails generator generating files (models, migration) and related specs.}
  spec.description   = %q{Automate the writing of validations, relations in files and specs. Create boilerplate validation in models, specs, migrations. This specs are generated based on rspec, shoulda-matchers and factorygirl }
  spec.homepage      = "http://github.com/vysakh0/rails_zen"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency 'thor', "~> 0.19"
  spec.add_dependency 'highline', "~> 1.4"
  spec.add_dependency 'activesupport', "~> 4.2"

  spec.add_development_dependency "bundler", "~> 1.7"
  spec.add_development_dependency "aruba", "~> 0.6"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.2"
end
