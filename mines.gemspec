Gem::Specification.new do |s|
  s.platform = Gem::Platform::RUBY
  s.name = 'mines'
  s.version = '0.0.1.alpha'
  s.summary = 'Data mining application framework.'
  s.description = 'Ruby in Mines is a framework for creating data mining application prototypes that focus on processing near real-time human generated content.'

  #s.required_ruby_version = '>= 1.9.3'
  #s.required_rubygems_version = '>= 1.8.11'

  s.license = 'MIT'

  s.author = 'Panayiotis Vlantis'
  s.email = 'p.vlantis@di.uoa.gr'
  #s.homepage = 'http://'

  s.bindir = 'bin'
  s.executables << 'mines'
  s.require_paths << "lib"
  s.files = Dir['lib/**/*.rb'] + Dir['bin/*.rb']

  s.add_dependency 'thor'
end
