require 'simplecov'

unless ENV['NOCOV']
  SimpleCov.start do
    enable_coverage :branch if ENV['BRANCH_COV']
    coverage_dir 'spec/coverage'
  end
end

require 'rubygems'
require 'bundler'
Bundler.require :default, :development

ENV['TTY'] = 'on'

include MisterBin
include Colsole

RSpec.configure do |config|
  config.example_status_persistence_file_path = 'spec/status.txt'
end
