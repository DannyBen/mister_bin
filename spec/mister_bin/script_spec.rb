require 'spec_helper'

describe Script do
  subject { described_class.new 'spec/workspace/app-ls.rb' }

  describe '#build_docopt' do
    it "returns a docopt string" do
      expect(subject.build_docopt).to match_fixture('script/build_docopt')
    end
  end

  describe '#execute' do
    before { subject.build_docopt }

    context "without args" do
      it "shows usage" do
        expect{ subject.execute }.to output_fixture('script/execute')
      end

      it "returns a non zero exit code" do
        supress_output do
          expect(subject.execute).to eq 1
        end
      end
    end

    context "with --help" do
      it "shows extended usage" do
        expect{ subject.execute ['--help'] }.to output_fixture('script/execute-help')
      end
    end

    context "with a valid command" do
      it "executes the action block" do
        expect{ subject.execute ['ls'] }.to output_fixture('script/ls')
      end
    end
  end

end