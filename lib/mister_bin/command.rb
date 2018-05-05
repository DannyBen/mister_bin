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
      script.execute argv
    end
  end
end