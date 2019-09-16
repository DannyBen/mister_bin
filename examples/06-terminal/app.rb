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
  list: %w[greet --help],
  header: "Welcome",
  autocomplete: %w[--help greet]
}
terminal.start


