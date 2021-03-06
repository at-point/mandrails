# -*- encoding: utf-8 -*-
require File.expand_path('../lib/mandrails/version', __FILE__)

Gem::Specification.new do |gem|
  gem.name          = "mandrails"
  gem.version       = Mandrails::VERSION
  gem.authors       = ["Lukas Westermann", "Philip Lehmann"]
  gem.email         = ["lukas@at-point.ch", "philip@at-point.ch"]
  gem.summary       = %q{An e-mail delivery method implementation which uses the Mandrill REST API.}
  gem.description   = %q{Provides a delivery method implementation for ActionMailer and mail which uses the Mandrill REST API.}
  gem.homepage      = "https://github.com/at-point/mandrails"

  gem.files         = %w{.gitignore Gemfile Rakefile README.md LICENSE.txt mandrails.gemspec} + Dir['{lib,spec}/**/*.rb']
  gem.test_files    = Dir['spec/**/*.rb']
  gem.require_paths = ["lib"]

  gem.required_ruby_version = '>= 1.9'

  gem.add_dependency 'mail', '>= 2.0'
  gem.add_dependency 'activesupport', '>= 4.0.0'
  gem.add_dependency 'mandrill-api', '>= 1.0'

  gem.add_development_dependency 'rake'
  gem.add_development_dependency 'rspec', '~> 2.12'
  gem.add_development_dependency 'actionmailer', '>= 4.0.0'
end
