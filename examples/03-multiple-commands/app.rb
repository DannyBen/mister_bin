#!/usr/bin/env ruby
require 'mister_bin'

# commands/greet_command.rb
class GreetCommand < MisterBin::Command
  summary 'Say hi'
  usage 'app greet [NAME]'
  param 'NAME', 'The recipient of the greeting'

  def run
    name = args['NAME'] || 'Luke'
    puts "#{name}... I am your father..."
  end
end

# commands/dir_command.rb
class DirCommand < MisterBin::Command
  summary 'Show list of files'
  help    'A longer help can optionally go here.'
  version '3.2.1'

  usage 'app dir'
  usage 'app dir --all'
  usage 'app dir DIR'

  option '--all', 'Also show hidden files'

  param 'DIR', 'Directory to list'

  example 'app dir'
  example 'app dir --all'

  environment 'SECRET', 'There is no spoon'

  def run
    puts args['--all'] ? 'success --all' : 'success'
  end
end

# bin/app
runner = MisterBin::Runner.new version: '1.2.3', header: 'Sample command',
  footer: 'For additional info, run g`app --help` or g`app COMMAND --help`'

runner.route 'greet',    to: GreetCommand
# `dir` is the main command, `ls` and any subsequent array element are aliases
runner.route %w[dir ls], to: DirCommand
runner.run ARGV

# Usage Examples:
#
# See available commands
# $ ./app.rb
#
# See version number
# $ ./app.rb -v
# $ ./app.rb --version
#
# See a detailed description of all commands
# $ ./app.rb -h
# $ ./app.rb --help
#
# See help for each command
# $ ./app.rb greet --help
# $ ./app.rb dir --help
# $ ./app.rb ls --help
#
# Execute a given command
# $ ./app.rb greet
# $ ./app.rb dir --all
