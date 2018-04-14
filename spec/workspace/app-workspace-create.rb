usage "app workspace create [WORKSPACE]"

help "Create workspace"

action do |args|
  puts "workspace #{args['WORKSPACE']} created successfully"
end