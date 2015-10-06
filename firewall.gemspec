# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'firewall/version'

Gem::Specification.new do |spec|
  spec.name          = "gem-firewall"
  spec.version       = Firewall::VERSION
  spec.authors       = ["Terranova David"]
  spec.email         = ["dterranova@adhara-cybersecurity.com"]
  spec.summary       = %q{IP based authorisation system}
  spec.description   = %q{IP based authorisation system}
  spec.homepage      = "https://github.com/davidterranova/gem-firewall"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.6"
  spec.add_development_dependency "minitest", "~> 4.7.3"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "debugger2"

  spec.add_dependency "ipaddress", "~> 0.8.0"
end
