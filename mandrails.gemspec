# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'mandrails/version'

Gem::Specification.new do |gem|
  gem.name          = "mandrails"
  gem.version       = Mandrails::VERSION
  gem.authors       = ["Lukas Westermann", "Philip Lehmann"]
  gem.email         = ["lukas@at-point.ch", "philip@at-point.ch"]
  gem.summary       = %q{An e-mail delivery method implementation which uses the Mandrill REST API.}
  gem.description   = %q{Provides a delivery method implementation for ActionMailer and mail which uses the Mandrill REST API.}
  gem.homepage      = ""

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]

  gem.signing_key   = "~/.ssh/gem-at-point.key"
  gem.cert_chain    = ["gem-at-point.pub"]

  gem.required_ruby_version = '>= 1.9'

  gem.add_dependency 'mail', '>= 2.0'
  gem.add_dependency 'activesupport', '>= 3.0'
  gem.add_dependency 'mandrill-api', '~> 1.0'

  gem.add_development_dependency 'rake'
  gem.add_development_dependency 'rspec', '~> 2.12'
  gem.add_development_dependency 'actionmailer', '>= 3.2'
end
