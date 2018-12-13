require 'colsole'

module MisterBin

  # This class is responsible for holding all the meta data for a command and
  # for generating a text string ready to be used by Docopt. 
  class CommandMeta
    include Colsole

    attr_reader :usages, :options, :examples, :params, :commands, :env_vars
    attr_accessor :summary, :help, :version

    def initialize
      @version  = nil
      @help     = nil
      @summary  = nil
      @usages   = []
      @options  = []
      @params   = []
      @commands = []
      @examples = []
      @env_vars = []
    end

    def docopt
      [summary_string, help_string, usage_string, commands_string,
        options_string, params_string, env_string, examples_string].compact.join "\n"
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

      if version
        result << "  --version"
        result << "    Show version number\n"
      end
      
      result.join "\n"
    end

    def params_string
      return nil if params.empty?
      key_value_block 'Parameters:', params
    end

    def env_string
      return nil if env_vars.empty?
      key_value_block 'Environment Variables:', env_vars
    end

    def commands_string
      return nil if commands.empty?
      key_value_block 'Commands:', commands
    end

    def examples_string
      return nil if examples.empty?

      result = ["Examples:"]
      examples.each { |text| result << word_wrap("  #{text}") }
      result << ""
      result.join "\n"
    end

    def key_value_block(caption, pairs)
      result = [caption]
      pairs.each do |key, value|
        result << "  #{key}"
        result << word_wrap("    #{value}")
        result << ""
      end

      result.join "\n"
    end

  end
end
