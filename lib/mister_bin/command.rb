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
        exitcode = new.run args
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

    end
  end
end
