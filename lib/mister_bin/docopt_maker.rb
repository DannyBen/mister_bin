require 'colsole'

module MisterBin

  # This singleton class is responsible for generating a text string ready to be used
  # by Docopt. 
  class DocoptMaker
    include Colsole

    attr_reader :usages, :options, :examples, :params, :env_vars
    attr_accessor :summary, :help, :version

    def initialize
      @version  = '0.0.0'
      @help     = nil
      @summary  = nil
      @usages   = []
      @options  = []
      @params   = []
      @examples = []
      @env_vars = []
    end

    def docopt
      [summary_string, help_string, usage_string, options_string, 
        params_string, env_string, examples_string].compact.join "\n"
    end

    private

    def summary_string
      summary ? word_wrap(summary) + "\n" : nil
    end

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

    def env_string
      return nil if env_vars.empty?

      result = ["Environment Variables:"]
      env_vars.each do |var|
        result << "  #{var[0]}"
        result << word_wrap("    #{var[1]}")
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