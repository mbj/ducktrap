# -*- encoding: utf-8 -*-

Gem::Specification.new do |gem|
  gem.name        = 'ducktrap'
  gem.version     = '0.0.2'
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

  gem.add_runtime_dependency('adamantium',    '~> 0.1.0')
  gem.add_runtime_dependency('equalizer',     '~> 0.0.7')
  gem.add_runtime_dependency('abstract_type', '~> 0.0.6')
  gem.add_runtime_dependency('anima',         '~> 0.2.0')
  gem.add_runtime_dependency('addressable',   '~> 2.3.5')
  gem.add_runtime_dependency('concord',       '~> 0.1.4')
end
