#!/usr/bin/env ruby
require 'mister_bin'

# demo_command.rb
class DemoCommand < MisterBin::Command
  # Optional summary string
  summary "A short sentence or paragraph describing the command"

  # Optional help string
  help "A longer explanation can go here"

  # Optional version string for the command
  version "0.1.1"

  # Usage patterns. You can use either a compact docopt notation, or provide
  # multiple usage calls.
  usage "app ls [--all]"
  usage "app new NAME [--force]"
  usage "app delete NAME"

  # Describe any flags
  option "--all", "Also show hidden files"
  option "-f --force", "Force delete"

  # Describe any parameters
  param "NAME", "The name of the repository"

  # Describe any subcommand
  # Note that this has an additional important use:
  # - For each command defined with the `command` directive, we will search 
  #   for a method with the same name and a `_command` suffix.
  # - If no such method is found, we will call the generic `run` method.
  command "ls", "Show list of files"
  command "new", "Pretend to create a new app"

  # Describe any environment variables that your app cares about
  environment "SECRET", "There is no spoon"

  # Provide examples
  example "app ls"
  example "app ls --all"

  # Implementation
  # In this example, the `ls` and `new` commands have specialized handlers,
  # while the `delete` command, will fall back to the `run` method.
  def ls_command(args)
    puts args['--all'] ? "Run this: ls -la" : "Run that: ls"
  end

  def new_command(args)
    name = args['NAME'] || 'Luke'
    puts "#{name}... I am your father..."
  end

  def run(args)
    puts "Fallback. A command that has no direct handler was called."
    p args
  end
end

# bin/app
runner = MisterBin::Runner.new handler: DemoCommand
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
# $ ./app.rb ls
# $ ./app.rb ls --all
# $ ./app.rb new Luke
# $ ./app.rb delete Luke
