require 'colsole'

module MisterBin
  class Runner
    include Colsole

    attr_reader :basefile, :basedir, :name, :header, :footer

    def self.run(basefile, argv=[], header: nil, footer: nil)
      new(basefile, header: header, footer: footer).run argv
    end

    def initialize(basefile, header: nil, footer: nil)
      @basefile = basefile
      @header = header
      @footer = footer
      @basedir = File.dirname basefile
      @name = File.basename basefile
    end

    def run(argv=[])
      if argv.empty?
        show_subs
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
      if commands.all.empty?
        puts "No subcommands found"
      else
        say "#{header}\n" if header
        puts "Commands:"
        commands.names.each { |command| puts "  #{name} #{command}" }
        say "\n#{footer}" if footer
      end

      return 1
    end

    def commands
      @commands ||= Commands.new name, basedir
    end
  end
end