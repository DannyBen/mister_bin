version "0.0.1"

help "Simulate git status"

usage "git status [--short]"

option "-s --short", "Show short list"

example "git status"
example "git status -s"

action do |args|
  puts args['--short'] ? "status with --short" : "status"
end