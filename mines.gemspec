Gem::Specification.new do |s|
  s.platform = Gem::Platform::RUBY
  s.name = 'mines'
  s.version = '0.0.1.alpha'
  s.summary = 'Data mining application framework.'
  s.description = 'Ruby in Mines is a framework for creating data mining application prototypes that focus on processing near real-time human generated content.'

  s.license = 'MIT'

  s.author = 'Panayiotis Vlantis'
  s.email = 'p.vlantis@di.uoa.gr'
  s.homepage = 'https://github.com/panayiotis/mines'

  s.bindir = 'bin'
  s.executables << 'mines'
  s.require_paths << "lib"
  s.files = Dir['bin/*.rb'] + Dir['lib/*.rb'] + Dir['lib/**/*.rb'] + Dir['lib/generators/templates/*.erb']

  s.add_dependency 'thor'
  s.add_dependency 'colored'
end
