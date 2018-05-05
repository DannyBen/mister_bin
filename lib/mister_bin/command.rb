module MisterBin
  class Command
    attr_reader :command, :file, :type

    def initialize(command, file)
      @command = command
      @file = file
      @type = command =~ / / ? :secondary : :primary
    end

    def run(argv=[])
      script.execute argv
    end

    def metadata
      script.metadata
    end

    private

    def script
      @script ||= Script.new file
    end
  end
end