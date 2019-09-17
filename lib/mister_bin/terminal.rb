require 'readline'
require 'colsole'
require 'shellwords'

module MisterBin
  class Terminal
    include Colsole

    attr_reader :runner, :options

    def initialize(runner, options=nil)
      @runner = runner
      @options = options || {}
    end

    def start
      Readline.completion_append_character = " "
      Readline.completion_proc = autocomplete_handler if autocomplete

      say header if header
      runner.run if show_usage
      loop { break unless safe_input_loop }
    end

  private

    def safe_input_loop
      input_loop
    # :nocov:
    rescue Interrupt
      say exit_message if exit_message
      false
    rescue => e
      puts e.backtrace.reverse if ENV['DEBUG']
      say! "!txtred!#{e.class}: #{e.message}"
      true
    # :nocov:
    end

    def input_loop
      while input = Readline.readline(prompt, true) do
        break unless execute input
      end
    end

    def execute(input)
      if exit_commands.include? input
        say exit_message if exit_message
        false
      else
        execute_command input
        true
      end
    end

    def execute_command(input)
      command = Shellwords.shellwords input

      if command.first&.start_with? system_character
        system input[1..-1]
      else
        runner.run command
      end
    end

    def header
      @header ||= options[:header]
    end

    def show_usage
      options[:show_usage]
    end

    def prompt
      @prompt ||= options[:prompt] || "\n> "
    end

    def autocomplete
      @autocomplete ||= options[:autocomplete]&.sort
    end

    def exit_message
      @exit_message ||= options[:exit_message]
    end

    def exit_commands
      @exit_commands ||= options[:exit_commands] || ['exit', 'q']
    end

    def system_character
      @system_character ||= options[:system_character] || '/'
    end

    def autocomplete_handler
      @autocomplete_handler ||= proc do |s|
        # :nocov:
        autocomplete.grep(/#{Regexp.escape(s)}/)
        # :nocov:
      end
    end

  end
end
