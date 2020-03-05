# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'pstore_pp/version'

Gem::Specification.new do |spec|
  spec.name          = 'pstore_pp'
  spec.version       = PStorePP::VERSION
  spec.authors       = ['Nicholas E. Rabenau']
  spec.email         = ['nerab@gmx.at']

  spec.summary       = 'Pretty-prints the contents of PStore files as JSON'
  spec.homepage      = 'https://github.com/nerab/pstore_pp'
  spec.license       = 'MIT'

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end

  spec.bindir        = 'bin'
  spec.executables   = spec.files.grep(%r{^#{spec.bindir}/}) do |f|
    File.basename(f)
  end

  spec.require_paths = ['lib']

  spec.add_development_dependency 'bundler'
  spec.add_development_dependency 'rake'
  spec.add_development_dependency 'minitest'
end
