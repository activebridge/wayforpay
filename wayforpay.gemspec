# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'wayforpay/version'

Gem::Specification.new do |s|
  s.name          = 'wayforpay'
  s.version       = Wayforpay::VERSION
  s.authors       = ['Serhii Savenko','Yaroslav Tupitskyi']
  s.email         = ['yarik@active-bridge.com']
  s.summary       = %q{Wayforpay API}
  s.description   = %q{Wayforpay API}
  s.homepage      = 'https://github.com/activebridge/wayforpay'
  s.license       = 'MIT'
  s.platform      = Gem::Platform::RUBY

  s.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  s.bindir        = 'exe'
  s.executables   = s.files.grep(%r{^exe/}) { |f| File.basename(f) }
  s.require_paths = ['lib']

  s.required_ruby_version = '>= 2.0.0'

  s.add_development_dependency 'bundler', '~> 1.14'
  s.add_development_dependency 'rake', '~> 10.0'
  s.add_development_dependency 'rspec', '~> 3.0'
  s.add_development_dependency 'webmock', '~> 1.6', '>= 1.6.2'
end
