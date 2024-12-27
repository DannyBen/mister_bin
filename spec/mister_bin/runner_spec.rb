require_relative '../samples/dir_command'
require_relative '../samples/global_command'
require_relative '../samples/push_command'

describe Runner do
  exit_code = nil

  subject(:runner) { described_class.new options }

  let(:options) { { header: 'head', footer: 'foot', version: '1.2.3' } }

  describe '#initialize' do
    it 'sets initial attribute values' do
      expect(runner.header).to eq 'head'
      expect(runner.footer).to eq 'foot'
      expect(runner.version).to eq '1.2.3'
      expect(runner.commands).to be_a Hash
    end
  end

  describe '#route' do
    it 'adds a command and a handler to the commands hash' do
      runner.route 'cmd', to: 'ClassConstant'
      expect(runner.commands['cmd']).to eq 'ClassConstant'
    end

    context 'with an array' do
      it 'adds the first array element as a command and the rest as aliases' do
        runner.route %w[dir ls list], to: 'ClassConstant'
        expect(runner.commands['dir']).to eq 'ClassConstant'
        expect(runner.aliases['ls']).to eq 'dir'
        expect(runner.aliases['list']).to eq 'dir'
      end
    end
  end

  describe '#route_all' do
    it 'sets a global handler' do
      runner.route_all to: 'ClassConstant'
      expect(runner.handler).to eq 'ClassConstant'
    end
  end

  describe '#run' do
    subject(:runner) do
      runner = described_class.new version: '1.2.3',
        header: 'This is a sample header.',
        footer: "This is a sample footer.\nUse --help for each command to get more information"

      runner.route 'dir', to: DirCommand
      runner.route %w[push upload deploy], to: PushCommand
      runner
    end

    it 'shows header, footer and subcommands' do
      expect { exit_code = runner.run }.to output_approval('runner/without-args')
      expect(exit_code).to eq 1
    end

    context 'with unknown command' do
      it 'shows an error and subcommands' do
        expect { exit_code = runner.run ['no-such-command'] }.to output_approval('runner/unknown')
        expect(exit_code).to eq 1
      end
    end

    context 'with --version' do
      it 'shows primary version number' do
        expect { exit_code = runner.run ['--version'] }.to output_approval('runner/version')
        expect(exit_code).to eq 0
      end
    end

    context 'with --help' do
      it 'shows all commands and their long description' do
        expect { exit_code = runner.run ['--help'] }.to output_approval('runner/help')
        expect(exit_code).to eq 0
      end

      context 'when no subcommands are defined' do
        subject(:runner) { described_class.new }

        it 'errors gracefully' do
          expect { exit_code = runner.run ['--help'] }.to output_approval('runner/no-subcommands')
          expect(exit_code).to eq 1
        end
      end
    end

    context 'with subcommand' do
      it 'executes the subcommand' do
        expect { exit_code = runner.run ['dir'] }.to output_approval('runner/dir')
        expect(exit_code).to eq 0
      end
    end

    context 'with an aliased command' do
      it 'executes the original command' do
        expect { exit_code = runner.run ['push'] }.to output_approval('runner/push')
        expect(exit_code).to eq 0
      end

      it 'executes the target command' do
        expect { exit_code = runner.run ['upload'] }.to output_approval('runner/push')
        expect(exit_code).to eq 0

        expect { exit_code = runner.run ['deploy'] }.to output_approval('runner/push')
        expect(exit_code).to eq 0
      end

      it 'accepts partial matches' do
        expect { exit_code = runner.run ['up'] }.to output_approval('runner/push')
        expect(exit_code).to eq 0
      end
    end

    context 'with subcommand --help' do
      it 'shows the help of the subcommand' do
        expect { exit_code = runner.run ['dir', '--help'] }.to output_approval('runner/dir-help')
        expect(exit_code).to eq 0
      end
    end

    context 'with subcommand --version' do
      it 'shows the version of the subcommand' do
        expect { exit_code = runner.run ['dir', '--version'] }.to output_approval('runner/dir-version')
        expect(exit_code).to eq 0
      end
    end

    context 'when no subcommands are defined' do
      subject(:runner) { described_class.new }

      it 'errors gracefully' do
        expect { exit_code = runner.run }.to output_approval('runner/no-subcommands')
        expect(exit_code).to eq 1
      end
    end

    context 'when using a global handler' do
      subject(:runner) { described_class.new handler: GlobalCommand }

      it 'sends all requests to the global handler' do
        expect { exit_code = runner.run }.to output_approval('runner/global-usage')
        expect(exit_code).to eq 1
      end

      it 'calls #run' do
        expect { exit_code = runner.run 'greet Luke' }.to output_approval('runner/global-run')
        expect(exit_code).to eq 0
      end
    end
  end
end
