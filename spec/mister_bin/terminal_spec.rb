require 'spec_helper'
require_relative '../samples/dir_command'
require_relative '../samples/global_command'

describe Terminal do
  subject(:terminal) { described_class.new runner, options }

  let(:runner) do
    runner = MisterBin::Runner.new
    runner.route 'dir', to: DirCommand
    runner
  end

  let(:options) { nil }

  describe 'terminal options' do
    let(:options) do
      {
        header:        'Hello bobbo',
        autocomplete:  %w[search list],
        prompt:        '>>>',
        exit_message:  'See you',
        exit_commands: %w[quit exit bye],
      }
    end

    it 'applies the options to the terminal' do
      allow(Readline).to receive(:readline)
        .with(options[:prompt], true)
        .and_return('quit')

      expect(Readline).to receive(:completion_proc=)

      expect { terminal.start }.to output_approval 'terminal/options'
    end
  end

  describe 'in-terminal command handling' do
    let(:input) { ['--help', false] }

    before do
      allow(Readline).to receive(:readline).and_return(*input)
    end

    it 'starts a terminal that runs commands on the runner' do
      expect { terminal.start }.to output_approval 'terminal/help'
    end

    context 'with a valid command' do
      let(:input) { ['dir --all', false] }

      it 'runs the command' do
        expect { terminal.start }.to output_approval 'terminal/command'
      end
    end

    context 'when the command starts with the system character' do
      let(:input) { ['/ls -la', false] }

      it 'runs the system command' do
        expect(terminal).to receive(:system).with('ls -la')
        terminal.start
      end

      context 'when system shell is disabled' do
        let(:options) { { disable_system_shell: true } }

        it 'does not run the system command' do
          expect(terminal).not_to receive(:system).with('ls -la')
          terminal.start
        end
      end
    end

    context 'with the exit command' do
      let(:input) { ['exit'] }
      let(:options) { { exit_message: 'Goodbye' } }

      it 'exits the terminal' do
        expect { terminal.start }.to output_approval 'terminal/exit'
      end
    end

    context 'with predefined reserved commands' do
      let(:input) { ['/hello world of goo', false] }

      before do
        terminal.on '/hello' do |args|
          puts '/hello called'
          p args
        end
      end

      it 'executes the block' do
        expect { terminal.start }.to output_approval 'terminal/reserved'
      end
    end
  end
end
