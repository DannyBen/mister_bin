require 'docopt'
require 'colsole'

module MisterBin
  class Command
    include Colsole

    class << self
      def description
        maker.summary || maker.help || ''
      end

      def execute(argv=[])
        args = Docopt.docopt docopt, version: maker.version, argv: argv
        instance = new
        target = find_target_command instance, args
        exitcode = instance.send target, args
        exitcode.is_a?(Numeric) ? exitcode : 0

      rescue Docopt::Exit => e
        puts e.message
        1
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

      def command(name, text)
        target_commands << name.to_sym
        maker.commands << [name, text]
      end

      def param(param, text)
        maker.params << [param, text]
      end

      def example(text)
        maker.examples << text
      end

      def environment(name, value)
        maker.env_vars << [name, value]
      end

    protected

      def maker
        @maker ||= DocoptMaker.new
      end

      def docopt
        maker.docopt
      end

    private

      def target_commands
        @target_commands ||= []
      end

      def find_target_command(instance, args)
        target_commands.each do |target|
          method_name = :"#{target}_command"
          return method_name if instance.respond_to? method_name and args[target.to_s]
        end
        :run
      end

    end

  end
end
