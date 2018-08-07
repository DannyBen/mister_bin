class GlobalCommand < MisterBin::Command
  usage "app greet NAME"

  def run(args)
    puts "hello #{args['NAME']}"
  end
end