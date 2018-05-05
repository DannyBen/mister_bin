require 'spec_helper'

describe DocoptMaker do
  describe '#docopt' do
    before do
      subject.usages << "mister --bin"
      subject.options << ["--bin", "Option explained here"]
      subject.version = '1.2.3'
      subject.examples << 'mister --bin'
      subject.help = 'Help text here'
      subject.summary = 'Summary text here'
    end

    it 'returns a string' do
      expect(subject.docopt).to match_fixture('docopt/base')
    end
  end
end
