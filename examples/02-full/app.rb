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
  # The first two will create the same result as the last one.
  usage "app ls"
  usage "app ls [--all]"
  usage "app new NAME [--force]"

  # Describe any flags
  option "--all", "Also show hidden files"
  option "-f --force", "Force delete"

  # Describe any parameters
  param "NAME", "The name of the repository"

  # Describe any subcommand
  command "ls", "Show list of files"
  command "new", "Pretend to create a new app"

  # Describe any environment variables that your app cares about
  environment "SECRET", "There is no spoon"

  # Provide examples
  example "app ls"
  example "app ls --all"

  # Implementation
  def run(args)
    if args['ls']
      puts args['--all'] ? "Run this: ls -la" : "Run that: ls"
    
    elsif args['new']
      name = args['NAME'] || 'Luke'
      puts "#{name}... I am your father..."

    end
  end
end

# bin/app
runner = MisterBin::Runner.new handler: DemoCommand
runner.run ARGV
