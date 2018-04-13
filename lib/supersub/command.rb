module Supersub
  class Command
    attr_reader :command, :file, :type

    def initialize(command, file)
      @command = command
      @file = file
      @type = command =~ / / ? :secondary : :primary
    end

    def run(argv)
      script = Script.new file
      docopt = script.build_docopt
      
      # p argv; puts "FIND ME IN Command"; exit

      args = Docopt.docopt docopt, version: DocoptMaker.instance.version, argv: argv
      script.execute argv
    rescue Docopt::Exit => e
      puts e.message
      1
    end

    def argv
      @argv ||= command.split ' '
    end

    private

    def docopt
      DocoptMaker.instance.docopt
    end

  end
end