require 'spec_helper'

describe Command do
  subject { described_class.new 'workspace create', 'spec/workspace' }

  describe '#run' do
    it 'executes the script' do
      allow_any_instance_of(Script).to receive(:build_docopt)
      expect_any_instance_of(Script).to receive(:execute)
      subject.run
    end
  end

  describe '#type' do
    context "with a primary command" do
      subject { described_class.new 'ls', 'spec/workspace' }

      it "returns :primary" do
        expect(subject.type).to eq :primary
      end
    end

    context "with a secondary command" do
      subject { described_class.new 'workspace create', 'spec/workspace' }

      it "returns :primary" do
        expect(subject.type).to eq :secondary
      end
    end
  end

end
