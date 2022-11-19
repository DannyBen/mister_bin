require 'spec_helper'

describe Runner do
  subject(:runner) { described_class.new options }

  let(:options) { { header: 'head', footer: 'foot', version: '1.2.3' } }

  describe '#initialize' do
    it 'sets initial attribute values' do
      expect(runner.header).to eq 'head'
      expect(runner.footer).to eq 'foot'
      expect(runner.version).to eq '1.2.3'
      expect(runner.commands).to be_a Hash
    end
  end

  describe '#route' do
    it 'adds a command and a handler to the commands hash' do
      runner.route 'cmd', to: 'ClassConstant'
      expect(runner.commands['cmd']).to eq 'ClassConstant'
    end
  end

  describe '#route_all' do
    it 'sets a global handler' do
      runner.route_all to: 'ClassConstant'
      expect(runner.handler).to eq 'ClassConstant'
    end
  end
end
