lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'date'
require 'mister_bin/version'

Gem::Specification.new do |s|
  s.name        = 'mister_bin'
  s.version     = MisterBin::VERSION
  s.date        = Date.today.to_s
  s.summary     = "Modular command line framefowk"
  s.description = "Build pluggable and modular command line tools with subcommands"
  s.authors     = ["Danny Ben Shitrit"]
  s.email       = 'db@dannyben.com'
  s.files       = Dir['README.md', 'lib/**/*.*']
  s.homepage    = 'https://github.com/dannyben/mister_bin'
  s.license     = 'MIT'
  s.required_ruby_version = ">= 2.4.0"

  s.add_runtime_dependency 'colsole', '~> 0.5'
  s.add_runtime_dependency 'docopt', '~> 0.6'

  s.add_development_dependency 'byebug', '~> 9.0'
  s.add_development_dependency 'rdoc', '~> 5.1'
  s.add_development_dependency 'rspec', '~> 3.6'
  s.add_development_dependency 'rspec_fixtures', '~> 0.3'
  s.add_development_dependency 'runfile', '~> 0.10'
  s.add_development_dependency 'runfile-tasks', '~> 0.4'
  s.add_development_dependency 'simplecov', '~> 0.15'
  s.add_development_dependency 'yard', '~> 0.9'
  s.add_development_dependency 'github_changelog_generator', '~> 1.14'
end
