# -*- encoding: utf-8 -*-

Gem::Specification.new do |gem|
  gem.name        = 'ducktrap'
  gem.version     = '0.1.0'
  gem.authors     = [ 'Markus Schirp' ]
  gem.email       = [ 'mbj@schir-dso.com' ]
  gem.description = 'Invertible data filter/mutator on data structures'
  gem.summary     = gem.description
  gem.homepage    = 'https://github.com/mbj/ducktrap'

  gem.require_paths    = [ 'lib' ]
  gem.files            = `git ls-files`.split("\n")
  gem.test_files       = `git ls-files -- spec`.split("\n")
  gem.extra_rdoc_files = %w[TODO]
  gem.license          = 'MIT'

  gem.add_runtime_dependency('morpher',       '~> 0.2.1')
  gem.add_runtime_dependency('anima',         '~> 0.2.0')
  gem.add_runtime_dependency('concord',       '~> 0.1.4')
end
