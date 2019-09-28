#!/usr/bin/env ruby
require 'mister_bin'

# commands/greet_command.rb
class GreetCommand < MisterBin::Command
  summary "Say hi"
  usage "app greet [NAME]"
  param "NAME", "The recipient of the greeting"

  def run
    name = args['NAME'] || 'Luke'
    puts "#{name}... I am your father..."
  end
end

# bin/app
runner = MisterBin::Runner.new 
runner.route 'greet', to: GreetCommand

terminal = MisterBin::Terminal.new runner, {
  header: "Welcome",
  autocomplete: %w[--help greet]
}

# optionally, define custom command overrides
terminal.on '/cd' do |args|
  Dir.chdir args[0] if args[0]
  puts Dir.pwd
end

# start the terminal
terminal.start


