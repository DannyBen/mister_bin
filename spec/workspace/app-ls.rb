help "Show list of files and more"
version "0.1.1"

usage "app ls"
usage "app ls --all"

option "--all", "Also show hidden files"

example "app ls"
example "app ls --all"

action do |args|
  puts args['--all'] ? "success --all" : "success"
end