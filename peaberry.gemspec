# -*- encoding: utf-8 -*-

$:.push File.expand_path('../lib', __FILE__)
require 'peaberry/version'

Gem::Specification.new do |s|
  s.name        = 'peaberry'
  s.version     = Peaberry::VERSION
  s.authors     = ['OZAWA Sakuro']
  s.email       = ['sakuro@2238club.org']
  s.homepage    = ''
  s.summary     = %q{A dotjs server clone}
  s.description = %q{Peaberry is a clone of dotjs server(djsd) which can serve CoffeeScript(s).}

  s.rubyforge_project = 'peaberry'

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ['lib']
  s.add_dependency 'coffee-script'
  s.add_dependency 'sprockets', '~> 2.0.0'
end
