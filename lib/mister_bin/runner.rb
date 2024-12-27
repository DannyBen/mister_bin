require 'colsole'

module MisterBin
  class Runner
    include Colsole

    attr_reader :header, :footer, :version, :commands, :handler

    def initialize(opts = {})
      @header = opts[:header]
      @footer = opts[:footer]
      @version = opts[:version]
      @commands = opts[:commands] || {}
      @handler = opts[:handler]
    end

    def route(key, to:)
      if key.is_a? Array
        target = key.shift
        commands[target] = to
        key.each { |alias_name| aliases[alias_name] = target }
      else
        commands[key] = to
      end
    end

    def route_all(to:)
      @handler = to
    end

    def run(argv = [])
      if handler
        handler.execute argv
      elsif argv.empty?
        show_subs
      elsif (argv == ['--help']) || (argv == ['-h'])
        show_help
      elsif version && ((argv == ['--version']) || (argv == ['-v']))
        show_version
      else
        execute argv
      end
    end

    def aliases
      @aliases ||= {}
    end

  private

    def execute(argv)
      argv = normalize_argv_command argv
      command = commands[argv[0]]

      if command
        command.execute argv
      else
        say "r`Unknown command`\n"
        show_subs
      end
    end

    def normalize_argv_command(argv)
      command = argv[0]
      return argv if commands.has_key? command

      argv[0] = find_target_command argv[0]
      argv
    end

    def find_target_command(input)
      candidates = commands.keys.grep(/^#{input}/)
      return candidates.first if candidates.count == 1

      candidates = aliases.keys.grep(/^#{input}/)
      return aliases[candidates.first] if candidates.count == 1

      input
    end

    def show_version
      puts version
      0
    end

    def show_subs
      if commands.empty?
        say 'No subcommands found'
      else
        show_subs!
      end

      1
    end

    def show_subs!
      longest_key = commands.keys.max_by(&:size).size
      max_summary_size = terminal_width - longest_key - 6

      say "#{header}\n" if header

      say 'Commands:'
      commands.each do |key, command|
        summary = command.meta.description
        summary = summary[0..max_summary_size].strip
        say "  gb`#{key.ljust longest_key}  `#{summary}"
      end

      say "\n#{footer}" if footer
    end

    def show_help
      if commands.empty?
        say 'No subcommands found'
        1
      else
        show_help!
        0
      end
    end

    def show_help!
      say "#{header}\n" if header

      commands.each do |key, command|
        meta = command.meta
        next unless meta.help || meta.summary

        say "g`#{key}`"
        help = meta.help || meta.summary
        say word_wrap "  #{help}"
        say ''
      end

      say footer.to_s if footer
    end
  end
end
