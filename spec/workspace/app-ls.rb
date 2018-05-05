summary "Show list of files and more"
help    "A longer help can optionallly go here."
version "0.1.1"

usage "app ls"
usage "app ls --all"
usage "app ls DIR"

option "--all", "Also show hidden files"

param "DIR", "Directory to list"

example "app ls"
example "app ls --all"

action do |args|
  puts args['--all'] ? "success --all" : "success"
end