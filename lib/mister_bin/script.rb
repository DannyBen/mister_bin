require 'docopt'
require 'colsole'

module MisterBin
  class Script
    # We are in cluding colsole to allow the evaluated script to use its
    # functions
    include Colsole

    attr_reader :file, :action_block

    def initialize(file)
      @file = file
    end

    def execute(argv=[])
      build_docopt
      execute! argv
    rescue Docopt::Exit => e
      puts e.message
      1
    end

    def docopt
      maker.docopt
    end

    def metadata
      @metadata ||= metadata!
    end

    # DSL

    def summary(text)
      maker.summary = text
    end

    def help(text)
      maker.help = text
    end

    def version(text)
      maker.version = text
    end

    def usage(text)
      maker.usages << text
    end

    def option(flags, text)
      maker.options << [flags, text]
    end

    def param(param, text)
      maker.params << [param, text]
    end

    def example(text)
      maker.examples << text
    end

    def action(&block)
      @action_block = block
    end

    private

    def metadata!
      instance_eval script

      { 
        summary: (maker.summary || maker.help), 
        version: maker.version 
      }
    end

    def execute!(argv)
      args = Docopt.docopt docopt, version: maker.version, argv: argv
      exitcode = action_block.call args if action_block
      exitcode.is_a?(Numeric) ? exitcode : 0
    end

    def build_docopt
      @maker = nil
      instance_eval script
      docopt
    end

    def maker
      @maker ||= DocoptMaker.new
    end

    def script
      @script ||= File.read file
    end
  end
end