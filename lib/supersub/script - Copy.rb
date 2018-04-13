require 'colsole'
require 'docopt'

module Supersub
  class Script
    attr_reader :command, :action_block

    def initialize(command)
      @command = command
    end

    def run(argv=[])
      # if argv.size > 1
      #   if meta_command? and command[name].keys.include? argv[1] 
      #     @file = command[name][argv[1]]
      #     run_docopt(argv)
      #   else
      #     puts "Invalid subcommand: #{argv[1]}\n\n"
      #     show_subcommands
      #   end
      # else          
        meta_command? ? show_subcommands : run_docopt(argv)
      # end
    end

    def docopt
      DocoptMaker.instance.docopt
    end

    def name
      @name ||= command.keys.first
    end

    def file
      @file ||= command[name].is_a?(String) ? command[name] : false
    end

    def meta_command?
      !file
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

    def action(&block)
      @action_block = block
    end

    private

    def run_docopt(argv)
      instance_eval script
      args = Docopt.docopt docopt, version: '0.0.0', argv: argv
      exitcode = action_block.call args if action_block
      exitcode || 0
    rescue Docopt::Exit => e
      puts e.message
      1
    end

    def show_subcommands
      puts "Subcommands:"
      command[name].keys.each do |key|
        puts "  #{name} #{key}"
      end
      return 1
    end

    def usages
      @usages ||= []
    end

    def options
      @options ||= []
    end

    def examples
      @examples ||= []
    end

    def script
      @script ||= File.read file
    end
  end
end