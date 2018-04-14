require 'singleton'
require 'colsole'

module MisterBin

  # This singleton class is responsible for generating a text string ready to be used
  # by Docopt. 
  class DocoptMaker
    include Singleton
    include Colsole

    attr_reader :usages, :options, :examples
    attr_accessor :help, :version

    def initialize
      reset
    end

    def reset
      @usages = []
      @options = []
      @examples = []
      @version = '0.0.0'
      @help = nil
    end

    def docopt
      [help_string, usage_string, options_string, examples_string].join "\n"
    end

    private

    def help_string
      word_wrap help
    end

    def usage_string
      result = ["", "Usage:"]
      usages.each { |text| result << word_wrap("  #{text}") }
      result.join "\n"
    end

    def options_string
      result = ["", "Options:"]
      options.each do |option|
        result << "  #{option[0]}"
        result << word_wrap("    #{option[1]}")
        result << ""
      end

      result << "  -h --help"
      result << "    Show this help\n"
      result << "  --version"
      result << "    Show version number"
      result.join "\n"
    end

    def examples_string
      return '' if examples.empty?

      result = ["", "Examples:"]
      examples.each { |text| result << word_wrap("  #{text}") }
      result.join "\n"
    end
  end
end