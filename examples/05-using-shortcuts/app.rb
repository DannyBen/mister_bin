#!/usr/bin/env ruby
require 'mister_bin'

# commands/greet_command.rb
class ServerCommand < MisterBin::Command
  usage "app server start"
  usage "app server stop"

  def run(args)
    p args
  end
end

# commands/shout_command.rb
class SayCommand < MisterBin::Command
  usage "app say SOMETHING"

  def run(args)
    p args
  end
end

# commands/shout_command.rb
class ConfigCommand < MisterBin::Command
  usage "app config edit"

  def run(args)
    p args
  end
end

# bin/app
runner = MisterBin::Runner.new 
runner.route 'server', to: ServerCommand
runner.route 'say',    to: SayCommand
runner.route 'config', to: ConfigCommand
runner.run ARGV


