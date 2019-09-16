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

      begin
        input_loop
      # :nocov:
      rescue Interrupt
        say exit_message if exit_message
        exit 1
      rescue => e
        puts e.backtrace.reverse if ENV['DEBUG']
        say! "!txtred!#{e.class}: #{e.message}"
      # :nocov:
      end
    end

  private

    def input_loop
      while input = Readline.readline(prompt, true) do
        if input == exit_command
          say exit_message if exit_message
          break
        end

        command = Shellwords.shellwords input
        if command.first.start_with? system_character
          system input[1..]
        else
          runner.run command
        end
      end
    end

    def system_character
      @system_character ||= options[:system_character] || '/'
    end

    def header
      @header ||= options[:header]
    end

    def autocomplete
      @autocomplete ||= options[:autocomplete]&.sort
    end

    def prompt
      @prompt ||= options[:prompt] || "\n> "
    end

    def exit_message
      @exit_message ||= options[:exit_message]
    end

    def exit_command
      @exit_command ||= options[:exit_command] || 'exit'
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
