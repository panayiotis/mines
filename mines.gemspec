# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)


Gem::Specification.new do |spec|
  spec.platform = Gem::Platform::RUBY
  spec.name = 'mines'
  spec.version = '0.0.2'
  spec.summary = 'Data mining application framework.'
  spec.description = 'Ruby in Mines is a framework for creating data mining application prototypes that focus on processing near real-time human generated content.'

  spec.license = 'MIT'

  spec.author = 'Panayiotis Vlantis'
  spec.email = 'p.vlantis@di.uoa.gr'
  spec.homepage = 'https://github.com/panayiotis/mines'

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]
  
  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "minitest"
  
  spec.add_dependency 'thor'
  spec.add_dependency 'colored'
  spec.add_dependency 'redis'
  spec.add_dependency 'hiredis'
  spec.add_dependency 'twitter'      
end
