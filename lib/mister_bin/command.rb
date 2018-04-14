module MisterBin
  class Command
    attr_reader :command, :file, :type

    def initialize(command, file)
      @command = command
      @file = file
      @type = command =~ / / ? :secondary : :primary
    end

    def run(argv=[])
      script = Script.new file
      script.build_docopt
      script.execute argv
    end

    def argv
      command.split ' '
    end
  end
end