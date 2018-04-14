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

  describe '#find' do
    it 'returns commands that start with the search array' do
      expect(subject.find(['w']).size).to eq 2
      expect(subject.find(['wo', 'c']).size).to eq 1
    end

    it 'returns the correct result' do
      result = subject.find(['wo', 'c'])
      result = result['workspace create']
      expect(result.command).to eq 'workspace create'
      expect(result.file).to eq "spec/workspace/app-workspace-create.rb"
    end
  end

  describe '#find_one' do
    context 'when there is one match' do
      it 'returns it' do
        expect(subject.find_one 'l').to be_a Command
      end
    end

    context 'when there is more than one match' do
      it 'returns false' do
        expect(subject.find_one 'w').to eq false
      end
    end

    context 'when there is less than one match' do
      it 'returns false' do
        expect(subject.find_one 'no-such-command').to eq false
      end
    end
  end
end
