require 'spec_helper'
require_relative '../samples/dir_command'
require_relative '../samples/global_command'

describe Terminal do
  let(:runner) do
    runner = MisterBin::Runner.new
    runner.route 'dir', to: DirCommand
    runner
  end

  let(:options) { nil }
  subject { described_class.new runner, options }

  describe 'terminal options' do
    let(:options) do
      {
        header: "Hello bobbo",
        autocomplete: %w[search list],
        prompt: ">>>",
        exit_message: 'See you',
        exit_commands: ['quit', 'exit', 'bye']
      }
    end

    it "applies the options to the terminal" do
      expect(Readline).to receive(:readline)
        .with(options[:prompt], true)
        .and_return('quit')

      expect(Readline).to receive(:completion_proc=)

      expect { subject.start }.to output_fixture 'terminal/options'
    end
    
  end

  describe 'in-terminal command handling' do
    let(:input) { ["--help", false] }
    
    before do
      expect(Readline).to receive(:readline).and_return(*input)
    end

    it "starts a terminal that runs commands on the runner" do
      expect { subject.start }.to output_fixture 'terminal/help'
    end

    context "with a valid command" do
      let(:input) { ["dir --all", false] }

      it "runs the command" do
        expect { subject.start }.to output_fixture 'terminal/command'
      end
    end

    context "when the command starts with the system character" do
      let(:input) { ["/ls -la", false] }

      it "runs the system command" do
        expect(subject).to receive(:system).with('ls -la')
        subject.start
      end
    end

    context "with the exit command" do
      let(:input) { ["exit"] }
      let(:options) { { exit_message: 'Goodbye' } }

      it "exits the terminal" do
        expect { subject.start }.to output_fixture 'terminal/exit'
      end
    end

  end
end
