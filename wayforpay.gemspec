# -*- encoding: utf-8 -*-
require File.expand_path('../lib/wayforpay/version', __FILE__)

Gem::Specification.new do |s|
  s.name          = 'wayforpay'
  s.version       = Wayforpay::VERSION
  s.authors       = ['Serhii Savenko','Yaroslav Tupitskyi']
  s.email         = ['yarik@active-bridge.com']
  s.homepage      = 'https://github.com/activebridge/wayforpay'
  s.summary       = %q{Wayforpay API}
  s.description   = %q{Wayforpay API}
  s.platform      = Gem::Platform::RUBY

  s.files         = `git ls-files`.split("\n")
  s.test_files    = s.files.grep(%r{^(test|spec|features)/})
  s.require_path  = 'lib'

  s.required_ruby_version = '>= 2.0.0'

  s.add_dependency 'builder', '>= 2.1.2'

  {
    'rake'    => '~> 0.8.7',
    'rspec'   => '~> 2.12',
    'webmock' => '~> 1.6.2'
  }.each { |l, v| s. add_development_dependency l, v }
end
