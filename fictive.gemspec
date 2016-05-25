# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'fictive/version'

Gem::Specification.new do |spec|
  spec.name          = 'fictive'
  spec.version       = Fictive::VERSION
  spec.authors       = ['Mark Rickerby']
  spec.email         = ['me@maetl.net']

  spec.summary       = %q{An authoring framework for choice fiction}
  spec.description   = %q{An authoring framework for creating choice fiction and interactive stories}
  spec.homepage      = 'https://github.com/maetl/fictive'
  spec.license       = 'MIT'

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(spec)/}) }
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_runtime_dependency 'mementus', '~> 0.2.0'

  spec.add_development_dependency 'bundler', '~> 1.10'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'rspec', '~> 3.4'
end
