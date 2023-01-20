require 'simplecov'
SimpleCov.start

require 'rubygems'
require 'bundler'
Bundler.require :default, :development

ENV['TTY'] = 'on'

include MisterBin
include Colsole

RSpec.configure do |config|
  config.example_status_persistence_file_path = 'spec/status.txt'
end
