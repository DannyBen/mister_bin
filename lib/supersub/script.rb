require 'colsole'
require 'docopt'

module Supersub
  class Script
    attr_reader :command, :help_text, :action_block

    def initialize(command)
      @command = command
    end

    def run(argv=[])
      if argv.size > 1
        if meta_command? and command[name].keys.include? argv[1] 
          @file = command[name][argv[1]]
          run_docopt(argv)
        else
          puts "Invalid subcommand: #{argv[1]}\n\n"
          show_subcommands
        end
      else          
        meta_command? ? show_subcommands : run_docopt(argv)
      end
    end

    def docopt
      [docopt_usage, docopt_options, docopt_examples].join "\n"
    end

    def docopt_usage
      result = ["", "Usage:"]
      if usages.empty?
        result << "  #{name}"
      else
        usages.each { |text| result << "  #{text}" }
      end
      result.join "\n"
    end

    def docopt_options
      return '' if options.empty?

      result = ["", "Options:"]
      options.each do |option|
        result << "  #{option[0]}"
        result << "    #{option[1]}"
      end
      result.join "\n"
    end

    def docopt_examples
      return '' if examples.empty?

      result = ["", "Examples:"]
      examples.each { |text| result << "  #{text}" }
      result.join "\n"
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
      @help_text = text
    end

    def usage(text)
      usages << text
    end

    def option(flags, text)
      options << [flags, text]
    end

    def action(&block)
      @action_block = block
    end

    def example(text)
      examples << text
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

    def screen_width
      @screen_width ||= detect_terminal_size[0]
    end
  end
end