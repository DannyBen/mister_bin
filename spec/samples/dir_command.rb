require 'mister_bin'

class DirCommand < MisterBin::Command
  summary "Show list of files and more"
  help    "A longer help can optionallly go here."
  version "3.2.1"

  usage "app dir"
  usage "app dir --all"
  usage "app dir DIR"

  option "--all", "Also show hidden files"

  param "DIR", "Directory to list"

  example "app dir"
  example "app dir --all"

  environment 'SECRET', 'There is no spoon'

  def run(args)
    puts args['--all'] ? "success --all" : "success"
  end
end