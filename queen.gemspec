# frozen_string_literal: true
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'queen/version'

Gem::Specification.new do |spec|
  spec.name          = "queen"
  spec.version       = Queen::VERSION
  spec.authors       = ["Piotr Murach"]
  spec.email         = [""]
  spec.summary       = %q{English language linter to hold your files in high esteem}
  spec.description   = <<-EOS
    English langauge linter that reports on spelling, grammar and other crimes against written word, and will help you hold your code and comments in high esteem.
  EOS
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.bindir        = "exe"
  spec.executables   = ["queen"]
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_runtime_dependency 'parser', '>= 2.4.0.2', '< 3.0'
  spec.add_runtime_dependency 'ffi-aspell', '~> 1.1.0'
  spec.add_runtime_dependency 'pastel', '~> 0.7.2'

  spec.add_development_dependency "bundler", "~> 1.16"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"
end
