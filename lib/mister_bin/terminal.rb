require 'reline'
require 'colsole'
require 'shellwords'

module MisterBin
  class Terminal
    include Colsole

    attr_reader :runner, :options

    def initialize(runner, options = nil)
      @runner = runner
      @options = options || {}
    end

    def on(command, &block)
      reserved_commands[command] = block
    end

    def start
      Reline.completion_append_character = ' '
      Reline.completion_proc = autocomplete_handler if autocomplete

      welcome_messages
      loop { break unless safe_input_loop }
    end

  private

    def autocomplete
      @autocomplete ||= options[:autocomplete]&.sort
    end

    def autocomplete_handler
      @autocomplete_handler ||= proc do |s|
        # :nocov:
        autocomplete.grep(/#{Regexp.escape(s)}/)
        # :nocov:
      end
    end

    def disable_system_shell
      options[:disable_system_shell]
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

      if reserved_commands.include? command.first
        reserved_commands[command.first].call command[1..]
      elsif !disable_system_shell && command.first&.start_with?(system_character)
        system input[1..]
      else
        runner.run command
      end
    end

    def exit_message
      @exit_message ||= options[:exit_message]
    end

    def exit_commands
      @exit_commands ||= options[:exit_commands] || %w[exit q]
    end

    def header
      @header ||= options[:header]
    end

    def input_loop
      while (input = Reline.readline prompt, true)
        break unless execute input
      end
    end

    def prompt
      @prompt ||= options[:prompt] || "\n> "
    end

    def reserved_commands
      @reserved_commands ||= {}
    end

    def safe_input_loop
      input_loop
      # :nocov:
    rescue Interrupt
      say exit_message if exit_message
      false
    rescue => e
      puts e.backtrace.reverse if ENV['DEBUG']
      say "r`#{e.class}`"
      say e.message
      true
      # :nocov:
    end

    def show_usage
      options[:show_usage]
    end

    def system_character
      @system_character ||= options[:system_character] || '/'
    end

    def welcome_messages
      say header if header
      runner.run if show_usage
    end
  end
end
