require 'spec_helper'

describe PathHelper do
  let(:paths) { ["noice/path", "another/noice/path"] }
  let(:pathspec) { paths.join File::PATH_SEPARATOR }


  describe '#new' do
    it 'defaults pathspec to ENV[PATH]' do
      expect(subject.pathspec).to eq ENV['PATH']
    end

    context "when pathspec is provided" do
      subject { described_class.new pathspec: pathspec }

      it "stores it instead of using ENV[PATH]" do
        expect(subject.pathspec).to eq pathspec
      end
    end
  end

  describe '#search' do
    subject { described_class.new pathspec: 'spec/workspace' }

    it "returns all files matching glob in serach paths" do
      expect(subject.search 'app').to eq ["spec/workspace/app"]
      expect(subject.search 'app*').to include 'spec/workspace/app-ls.rb'
      expect(subject.search('app*').size).to eq 4
    end
  end

  describe '#paths' do
    subject { described_class.new pathspec: pathspec }

    it "returns an array of paths" do
      expect(subject.paths).to eq paths
    end

    context "with additional_dir" do
      subject { described_class.new pathspec: pathspec, additional_dir: 'spec/workspace' }

      it "returns an array of paths + additional_dir" do
        expect(subject.paths).to include 'spec/workspace'
        expect(subject.paths).to include paths.first
      end
    end
  end
end
