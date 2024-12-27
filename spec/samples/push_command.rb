require 'mister_bin'

class PushCommand < MisterBin::Command
  summary 'Push all to production'

  usage 'app push [--force]'
  option '--force', 'Force deploy'

  def run
    puts args['--force'] ? 'pushed with --force' : 'pushed'
  end
end
