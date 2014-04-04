# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'call_sp/version'

Gem::Specification.new do |spec|
  spec.name          = "call_sp"
  spec.version       = CallSp::VERSION
  spec.authors       = ["Igor Gonchar"]
  spec.email         = ["gigorok@gmail.com"]
  spec.summary       = %q{"ActiveRecord extensions for PostgreSQL."}
  spec.description   = %q{"ActiveRecord extensions for PostgreSQL. Provides useful tools for working with stored procedures."}
  spec.homepage      = "http://github.com/gigorok/call_sp"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency(%q<rspec-rails>, [">= 0"])
end
