require 'spec_helper'

describe CommandMeta do
  subject(:meta) { described_class.new }

  let(:summary) { 'it was a summary summer' }
  let(:help) { 'he was a helpless helper' }

  describe '#description' do
    context 'when summary is set' do
      before { meta.summary = summary }

      it 'returns the summary' do
        expect(meta.description).to eq summary
      end
    end

    context 'when summary is not set and help is set' do
      before { meta.help = help }

      it 'returns the help' do
        expect(meta.description).to eq help
      end
    end

    context 'when both summary and help are not set' do
      it 'returns an empty string' do
        expect(meta.description).to eq ''
      end
    end
  end

  describe '#long_description' do
    context 'when summary is set' do
      before { meta.summary = summary }

      it 'returns the summary' do
        expect(meta.long_description).to eq summary
      end
    end

    context 'when summary is not set and help is set' do
      before { meta.help = help }

      it 'returns the help' do
        expect(meta.long_description).to eq help
      end
    end

    context 'when both summary and help are set' do
      before do
        meta.help = help
        meta.summary = summary
      end

      it 'returns both with a newline separation' do
        expect(meta.long_description).to eq "#{summary}\n\n#{help}"
      end
    end
  end

  describe '#docopt' do
    context 'with all properties set' do
      before do
        meta.usages << 'mister --bin'
        meta.options << ['--bin', 'Option explained here']
        meta.version = '1.2.3'
        meta.examples << 'mister --bin'
        meta.params << ['NAME', 'Directory name']
        meta.commands << ['ls', 'Show list of files']
        meta.help = 'Help text here'
        meta.summary = 'Summary text here'
        meta.env_vars << ['SECRET', 'There is no spoon']
      end

      it 'returns a string' do
        expect(meta.docopt).to match_approval('docopt/base')
      end
    end

    context 'without version' do
      before { meta.usages << 'mister --bin' }

      it 'does not show --version in help string' do
        expect(meta.docopt).to match_approval('docopt/minimal')
      end
    end
  end
end
