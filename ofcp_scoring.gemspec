# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'ofcp_scoring/version'

Gem::Specification.new do |spec|
  spec.name          = "ofcp_scoring"
  spec.version       = OfcpScoring::VERSION
  spec.authors       = ["Clayton Lengel-Zigich"]
  spec.email         = ["clayton@claytonlz.com"]
  spec.description   = %q{Open Face Chinese Poker Scoring}
  spec.summary       = %q{A library to categorize, rank and score open face chinese poker hands with royalties.}
  spec.homepage      = "http://github.com/clayton/ofcp_scoring"
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec"
end
