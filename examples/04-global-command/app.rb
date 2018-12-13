#!/usr/bin/env ruby
require 'mister_bin'

# commands/global_command.rb
class GlobalCommand < MisterBin::Command
  usage "app say [MESSAGE]"
  usage "app shout [MESSAGE]"

  def run
    message = args['MESSAGE'] || 'hello'

    if args['say']
      puts message
    elsif args['shout']
      puts message.upcase
    end
  end
end

# bin/app
runner = MisterBin::Runner.new handler: GlobalCommand
runner.run ARGV


# Usage Examples:
#
# See available commands
# $ ./app.rb
# 
# See help
# $ ./app.rb --help
# 
# Execute a given command
# $ ./app.rb say hello
# $ ./app.rb shout
