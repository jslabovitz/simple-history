Gem::Specification.new do |s|
  s.name          = 'simple-history'
  s.version       = '0.1'
  s.summary       = 'History manager'
  s.author        = 'John Labovitz'
  s.email         = 'johnl@johnlabovitz.com'
  s.description   = %q{
    Simple::History is a history manager.
  }.strip
  s.license       = 'MIT'
  s.homepage      = 'http://github.com/jslabovitz/simple-history'
  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map { |f| File.basename(f) }
  s.require_path  = 'lib'

  s.add_dependency 'json', '~> 2.6'

  s.add_development_dependency 'bundler', '~> 2.3'
  s.add_development_dependency 'minitest', '~> 5.16'
  s.add_development_dependency 'minitest-power_assert', '~> 0.3'
  s.add_development_dependency 'rake', '~> 13.0'

end