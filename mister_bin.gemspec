lib = File.expand_path('lib', __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'mister_bin/version'

Gem::Specification.new do |s|
  s.name        = 'mister_bin'
  s.version     = MisterBin::VERSION
  s.summary     = 'Command line interface for your gems'
  s.description = 'Easily add command line interface to your gems'
  s.authors     = ['Danny Ben Shitrit']
  s.email       = 'db@dannyben.com'
  s.files       = Dir['README.md', 'lib/**/*.*']
  s.homepage    = 'https://github.com/dannyben/mister_bin'
  s.license     = 'MIT'
  s.required_ruby_version = '>= 3.0'

  s.add_runtime_dependency 'colsole', '>= 0.8.1', '< 2'
  s.add_runtime_dependency 'docopt_ng', '~> 0.7', '>= 0.7.1'

  s.metadata = {
    'bug_tracker_uri'       => 'https://github.com/DannyBen/mister_bin/issues',
    'changelog_uri'         => 'https://github.com/DannyBen/mister_bin/blob/master/CHANGELOG.md',
    'source_code_uri'       => 'https://github.com/DannyBen/mister_bin',
    'rubygems_mfa_required' => 'true',
  }
end
