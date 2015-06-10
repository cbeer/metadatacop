# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'metadatacop/version'

Gem::Specification.new do |spec|
  spec.name          = 'metadatacop'
  spec.version       = MetadataCop::VERSION
  spec.authors       = ['Chris Beer']
  spec.email         = ['chris@cbeer.info']

  spec.summary       = 'Style enforcement for metadata'
  spec.homepage      = 'https://github.com/cbeer/metadatacop'

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_dependency 'activesupport'
  spec.add_dependency 'nokogiri'
  spec.add_dependency 'mods'

  spec.add_development_dependency 'bundler', '~> 1.9'
  spec.add_development_dependency 'rake', '~> 10.0'
end
