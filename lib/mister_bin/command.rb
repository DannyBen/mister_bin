require 'docopt'
require 'colsole'

module MisterBin
  class Command
    include Colsole

    attr_reader :args

    def initialize(args = nil)
      @args = args
    end

    class << self
      def execute(argv = [])
        args = Docopt.docopt docopt, version: meta.version, argv: argv
        instance = new args
        target = find_target_command instance, args
        exitcode = instance.send target
        exitcode.is_a?(Numeric) ? exitcode : 0
      rescue Docopt::Exit => e
        puts e.message
        1
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

    protected

      def docopt
        meta.docopt
      end

    private

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
