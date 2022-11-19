#!/usr/bin/env ruby
require 'mister_bin'

# commands/server_command.rb
class ServerCommand < MisterBin::Command
  usage 'app server start'
  usage 'app server stop'

  def run
    p args
  end
end

# commands/say_command.rb
class SayCommand < MisterBin::Command
  usage 'app say SOMETHING'

  def run
    p args
  end
end

# commands/config_command.rb
class ConfigCommand < MisterBin::Command
  usage 'app config edit'

  def run
    p args
  end
end

# bin/app
runner = MisterBin::Runner.new
runner.route 'server', to: ServerCommand
runner.route 'say',    to: SayCommand
runner.route 'config', to: ConfigCommand
runner.run ARGV

# Usage Examples:
#
# See available commands
# $ ./app.rb
#
# Execute a given command
# $ ./app.rb server start
# $ ./app.rb config edit
#
# Execute a given command by just using its first letters
# $ ./app.rb se start
# $ ./app.rb c edit
#
# This will not execute properly, since there are two commands that
# start with an `s`.
# $ ./app.rb s start
