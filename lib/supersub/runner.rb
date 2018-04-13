module Supersub
  class Runner
    attr_reader :name

    def self.run(name, argv=[])
      new(name).run argv
    end

    def initialize(name)
      @name = name
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
      command = commands.find_one argv[0]

      if command
        execute_command command, argv
      else
        puts "Unknown command: #{argv[0]}"
        return 1
      end
    end

    def execute_command(command, argv)
      Script.new(command).run argv
    end

    def show_subs
      if commands.all.empty?
        puts "No subcommands found"
      else
        puts "Usage:"
        commands.all.keys.each { |sub| puts "  #{name} #{sub}" }
      end

      return 1
    end

    def commands
      @commands ||= Commands.new name
    end
  end
end