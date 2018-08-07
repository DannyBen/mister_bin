#!/usr/bin/env ruby
require 'mister_bin'

# commands/global_command.rb
class GlobalCommand < MisterBin::Command
  usage "app say [MESSAGE]"
  usage "app shout [MESSAGE]"

  def run(args)
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
