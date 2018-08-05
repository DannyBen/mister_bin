require 'spec_helper'

describe Command do
  subject { described_class.dup }

  describe '::description' do
    context "when summary is set" do
      let(:summary) { 'it was a summary summer' }
      before { subject.summary summary }

      it "returns the summary" do
        expect(subject.description).to eq summary
      end
    end

    context "when summary is not set and help is set" do
      let(:help) { 'it was a summary summer' }
      before { subject.help help }

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
end
