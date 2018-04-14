require 'spec_helper'

describe Commands do
  subject { described_class.new 'app', 'spec/workspace' }

  describe '#all' do
    it 'returns a hash of Command objects' do
      expect(subject.all).to be_a Hash
      expect(subject.all['ls']).to be_a Command
    end
  end

  describe '#names' do
    it 'returns an array of command names' do
      expect(subject.names).to eq ["ls", "why", "workspace create"]
    end
  end

  describe '#find', :focus do
    context "when searching for a secondary command" do
      it "returns a matching command" do
        command = subject.find('workspace', 'create')
        expect(command.command).to eq "workspace create"
        expect(command.file).to eq "spec/workspace/app-workspace-create.rb"
      end
    end

    context "when searching for a primary command" do
      it "returns a matching command" do
        command = subject.find('ls')
        expect(command.command).to eq "ls"
        expect(command.file).to eq "spec/workspace/app-ls.rb"
      end
    end

    context "when searching for an invalid command" do
      it "returns nil" do
        command = subject.find('nocommand')
        expect(command).to be_nil        
      end
    end
  end
end
