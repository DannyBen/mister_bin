require 'colsole'

module MisterBin
  class Runner
    include Colsole

    attr_reader :header, :footer, :version, :commands, :handler

    def initialize(opts={})
      @header = opts[:header]
      @footer = opts[:footer]
      @version = opts[:version]
      @commands = opts[:commands] || {}
      @handler = opts[:handler]
    end

    def route(key, to:)
      commands[key] = to
    end

    def route_all(to:)
      @handler = to
    end

    def run(argv=[])
      if handler
        handler.execute argv
      elsif argv.empty?
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
      command = find_command argv

      if command
        command.execute argv
      else
        say "!txtred!Unknown command\n"
        show_subs
      end
    end

    def find_command(argv)
      argv_line = argv.join ' '
      candidates = commands.keys.select { |c| argv_line =~ /^#{c}\b/ }
      candidate = candidates.first
      candidate ? commands[candidate] : nil
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
        summary = command.description
        summary = summary[0..max_summary_size].strip
        say "  !bldgrn!#{key.ljust longest_key}  !txtrst!#{summary}"
      end

      say "\n#{footer}" if footer
    end

  end
end