require 'mister_bin'

class GreetCommand < MisterBin::Command
  summary "Say hi"
  usage "app greet [NAME]"
  param "NAME", "The recipient of the greeting"

  def run(args)
    name = args['NAME'] || 'Luke'
    puts "#{name}... I am your father..."
  end
end