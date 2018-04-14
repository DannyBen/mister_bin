require 'docopt'

module MisterBin
  class Script
    attr_reader :file, :action_block

    def initialize(file)
      @file = file
    end

    def build_docopt
      DocoptMaker.instance.reset
      instance_eval script
      docopt
    end

    def execute(argv=[])
      args = Docopt.docopt docopt, version: DocoptMaker.instance.version, argv: argv
      exitcode = action_block.call args if action_block
      exitcode.is_a?(Numeric) ? exitcode : 0
    rescue Docopt::Exit => e
      puts e.message
      1
    end

    def docopt
      DocoptMaker.instance.docopt
    end

    # DSL

    def help(text)
      DocoptMaker.instance.help = text
    end

    def usage(text)
      DocoptMaker.instance.usages << text
    end

    def option(flags, text)
      DocoptMaker.instance.options << [flags, text]
    end

    def example(text)
      DocoptMaker.instance.examples << text
    end

    def version(text)
      DocoptMaker.instance.version = text
    end

    def action(&block)
      @action_block = block
    end

    private

    def script
      @script ||= File.read file
    end
  end
end