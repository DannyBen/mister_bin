require 'spec_helper'

describe Runner do
  let(:basefile) { 'spec/workspace/app' }
  let(:opts) {{ header: '!txtgrn!Header', footer: 'The !txtred!End' }}
  
  subject { described_class.new basefile, opts }

  describe '::run' do
    it 'calls #run on a new instance' do
      expect_any_instance_of(Runner).to receive(:run).with([1,2,3])
      described_class.run basefile, [1,2,3]
    end
  end

  describe '#run' do
    context "with empty argv" do
      it "shows subcommands" do
        expect{ subject.run }.to output_fixture('runner/run')
      end
    end

    context "with arguments" do
      it "executes the command" do
        expect{ subject.run ['ls'] }.to output_fixture('runner/run-ls')
      end
    end

    context "with an unknown command" do
      it "executes the command" do
        expect{ subject.run ['unknown'] }.to output_fixture('runner/run-unknown')
      end
    end

    context "when no subcommands are fonud" do
      let(:basefile) { 'spec/workspace/nosuchcommand' }

      it "errors gracefully" do
        expect{ subject.run }.to output_fixture('runner/run-no-subs')
      end
    end
  end

end
