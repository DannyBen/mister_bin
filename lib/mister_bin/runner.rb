require 'colsole'

module MisterBin
  class Runner
    include Colsole

    attr_reader :name, :basedir, :header, :footer, :isolate, :version

    def initialize(name, opts={})
      @name = name
      @header = opts[:header]
      @footer = opts[:footer]
      @isolate = opts[:isolate]
      @basedir = opts[:basedir]
      @version = opts[:version]
    end

    def run(argv=[])
      if argv.empty?
        show_subs
      elsif argv == ['--version'] and version
        puts version
        return 1
      else
        execute argv
      end
    end

    private

    def execute(argv)
      command = commands.find argv[0], argv[1]

      if command
        execute_command command, argv
      else
        puts "Unknown command: #{argv[0]}\n\n"
        show_subs
      end
    end

    def execute_command(command, argv)
      command.run argv
    end

    def show_subs
      if commands.empty?
        say "No subcommands found"
      else
        show_subs!
      end

      return 1
    end

    def show_subs!
      longest_key = commands.keys.max_by(&:size).size
      max_summary_size = terminal_width - longest_key - 6

      say "#{header}\n" if header
      
      say "Commands:"
      commands.each do |key, command|
        summary = command.metadata[:summary] || ''
        summary = summary[0..max_summary_size].strip
        say "  !bldgrn!#{key.ljust longest_key}  !txtrst!#{summary}"
      end

      say "\n#{footer}" if footer
    end

    def commands
      @commands ||= Commands.new name, basedir, isolate: isolate
    end
  end
end