class GlobalCommand < MisterBin::Command
  usage "app greet NAME"

  def run
    puts "hello #{args['NAME']}"
  end
end