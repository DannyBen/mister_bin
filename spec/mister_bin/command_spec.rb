require_relative '../samples/dir_command'

describe Command do
  subject(:command) { DirCommand.new args }

  let(:args) { nil }

  describe '#initialize' do
    let(:args) { { 'FILE' => 'out.txt', '--verbose' => false } }

    it 'accepts hash arguments' do
      expect(command.args).to eq args
    end
  end

  describe '#execute' do
    it 'runs the command' do
      expect { command.execute }.to output_approval('command/dir_command_usage')
    end
  end
end
