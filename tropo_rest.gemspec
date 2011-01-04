# -*- encoding: utf-8 -*-
require File.expand_path("../lib/tropo_rest/version", __FILE__)

Gem::Specification.new do |s|
  s.name        = "tropo_rest"
  s.version     = TropoRest::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Christopher Durtschi"]
  s.email       = ["christopher.durtschi@gmail.com"]
  s.homepage    = "http://rubygems.org/gems/tropo_rest"
  s.summary     = "Library to interact with Tropo's REST API"
  s.description = "A simple wrapper for the Tropo REST API to manipulate applications, addresses, exchanges, sessions."

  s.required_rubygems_version = ">= 1.3.6"
  s.rubyforge_project         = "tropo_rest"

  s.add_development_dependency "bundler", ">= 1.0.0"
  s.add_development_dependency "rake", "~> 0.8.7"
  s.add_development_dependency "rspec", "~> 2.3.0"
  s.add_development_dependency "webmock", "~> 1.6.1"
  s.add_development_dependency "autotest", "~> 4.3.2"

  case RUBY_PLATFORM
  when /darwin/
    s.add_development_dependency "autotest-fsevent", "~> 0.2.4"
    s.add_development_dependency "autotest-growl", "~> 0.2.9"
  end

  case RUBY_VERSION
  when /^1\.9/
    s.add_development_dependency "ruby-debug19"
  when /^1\.8/
    s.add_development_dependency "ruby-debug"
  end

  s.add_runtime_dependency "faraday", "~> 0.5.3"

  s.files        = `git ls-files`.split("\n")
  s.executables  = `git ls-files`.split("\n").map{|f| f =~ /^bin\/(.*)/ ? $1 : nil}.compact
  s.require_path = 'lib'
end
