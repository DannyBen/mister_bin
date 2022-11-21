require 'docopt'
require 'colsole'

module MisterBin
  class Command
    include Colsole

    attr_reader :args

    def execute(argv = [])
      @args = Docopt.docopt self.class.docopt, version: self.class.meta.version, argv: argv
      target = self.class.find_target_command self, args
      exitcode = send target
      exitcode.is_a?(Numeric) ? exitcode : 0
    rescue Docopt::Exit => e
      puts e.message
      1
    end

    class << self
      def execute(argv = [])
        new.execute argv
      end

      # DSL

      def summary(text)
        meta.summary = text
      end

      def help(text)
        meta.help = text
      end

      def version(text)
        meta.version = text
      end

      def usage(text)
        meta.usages << text
      end

      def option(flags, text)
        meta.options << [flags, text]
      end

      def command(name, text)
        target_commands << name.to_sym
        meta.commands << [name, text]
      end

      def param(param, text)
        meta.params << [param, text]
      end

      def example(text)
        meta.examples << text
      end

      def environment(name, value)
        meta.env_vars << [name, value]
      end

      def meta
        @meta ||= CommandMeta.new
      end

      def docopt
        meta.docopt
      end

      def target_commands
        @target_commands ||= []
      end

      def find_target_command(instance, args)
        target_commands.each do |target|
          method_name = :"#{target}_command"
          return method_name if instance.respond_to?(method_name) && args[target.to_s]
        end
        :run
      end
    end
  end
end
