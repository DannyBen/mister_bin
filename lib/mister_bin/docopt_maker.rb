require 'colsole'

module MisterBin

  # This singleton class is responsible for generating a text string ready to be used
  # by Docopt. 
  class DocoptMaker
    include Colsole

    attr_reader :usages, :options, :examples, :params
    attr_accessor :help, :version

    def initialize
      @usages = []
      @options = []
      @params = []
      @examples = []
      @version = '0.0.0'
      @help = nil
    end

    def docopt
      [help_string, usage_string, options_string, 
        params_string, examples_string].compact.join "\n"
    end

    private

    def help_string
      help ? word_wrap(help) + "\n" : nil
    end

    def usage_string
      result = ["Usage:"]
      usages.each { |text| result << word_wrap("  #{text}") }
      result << ""
      result.join "\n"
    end

    def options_string
      result = ["Options:"]
      options.each do |option|
        result << "  #{option[0]}"
        result << word_wrap("    #{option[1]}")
        result << ""
      end

      result << "  -h --help"
      result << "    Show this help\n"
      result << "  --version"
      result << "    Show version number\n"
      result.join "\n"
    end

    def params_string
      return nil if params.empty?

      result = ["Parameters:"]
      params.each do |param|
        result << "  #{param[0]}"
        result << word_wrap("    #{param[1]}")
        result << ""
      end

      result.join "\n"
    end

    def examples_string
      return nil if examples.empty?

      result = ["Examples:"]
      examples.each { |text| result << word_wrap("  #{text}") }
      result << ""
      result.join "\n"
    end
  end
end