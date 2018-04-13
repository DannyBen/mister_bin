require 'singleton'

module MisterBin
  class DocoptMaker
    include Singleton

    attr_reader :usages, :options, :examples
    attr_accessor :help, :version

    def initialize
      @usages = []
      @options = []
      @examples = []
      @version = '0.0.0'
      @help = nil
    end

    def docopt
      [help, usage_string, options_string, examples_string].join "\n"
    end

    private

    def usage_string
      result = ["", "Usage:"]
      usages.each { |text| result << "  #{text}" }
      result.join "\n"
    end

    def options_string
      result = ["", "Options:"]
      options.each do |option|
        result << "  #{option[0]}"
        result << "    #{option[1]}\n"
      end

      result << "  -h --help"
      result << "    Show this help"
      result << "  --version"
      result << "    Show version number"
      result.join "\n"
    end

    def examples_string
      return '' if examples.empty?

      result = ["", "Examples:"]
      examples.each { |text| result << "  #{text}" }
      result.join "\n"
    end
  end
end