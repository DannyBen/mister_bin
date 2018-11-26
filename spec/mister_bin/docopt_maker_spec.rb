require 'spec_helper'

describe DocoptMaker do
  describe '#docopt' do
    context "with all properties set" do
      before do
        subject.usages << "mister --bin"
        subject.options << ["--bin", "Option explained here"]
        subject.version = '1.2.3'
        subject.examples << 'mister --bin'
        subject.params << ["NAME", "Directory name"]
        subject.commands << ["ls", "Show list of files"]
        subject.help = 'Help text here'
        subject.summary = 'Summary text here'
        subject.env_vars << ['SECRET', 'There is no spoon']
      end

      it 'returns a string' do
        expect(subject.docopt).to match_fixture('docopt/base')
      end
    end

    context 'without version' do
      before do
        subject.usages << "mister --bin"
      end

      it 'does not show --version in help string' do
        expect(subject.docopt).to match_fixture('docopt/minimal')
      end
    end
  end
end
