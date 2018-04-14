version "0.0.1"

help "Create a new repo"

usage "git repo new NAME"

example "git repo new hello"

action do |args|
  puts "Simulating 'repo new' with #{args['NAME']}"
end