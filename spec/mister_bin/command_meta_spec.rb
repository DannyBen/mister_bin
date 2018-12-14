require 'spec_helper'

describe CommandMeta do
  let(:summary) { 'it was a summary summer' }
  let(:help) { 'he was a helpless helper' }

  describe '#description' do
    context "when summary is set" do
      before { subject.summary = summary }

      it "returns the summary" do
        expect(subject.description).to eq summary
      end
    end

    context "when summary is not set and help is set" do
      before { subject.help = help }

      it "returns the help" do
        expect(subject.description).to eq help
      end
    end

    context "when both summary and help are not set" do
      it "returns an empty string" do
        expect(subject.description).to eq ''
      end
    end
  end

  describe '#long_description' do
    context "when summary is set" do
      before { subject.summary = summary }

      it "returns the summary" do
        expect(subject.long_description).to eq summary
      end
    end

    context "when summary is not set and help is set" do
      before { subject.help = help }

      it "returns the help" do
        expect(subject.long_description).to eq help
      end
    end

    context "when both summary and help are set" do
      before do
        subject.help = help
        subject.summary = summary
      end

      it "returns both with a newline separation" do
        expect(subject.long_description).to eq "#{summary}\n\n#{help}"
      end
    end
  end


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
