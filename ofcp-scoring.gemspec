# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'ofcp/scoring/version'

Gem::Specification.new do |spec|
  spec.name          = "ofcp-scoring"
  spec.version       = Ofcp::Scoring::VERSION
  spec.authors       = ["Clayton Lengel-Zigich"]
  spec.email         = ["clayton@claytonlz.com"]
  spec.description   = %q{A scoring engine for Open Face Chinese Poker}
  spec.summary       = %q{A scoring engine for Open Face Chinese Poker}
  spec.homepage      = "http://github.com/clayton/ofcp-scoring"
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
end
