require 'spec_helper'

describe Runner do
  let(:options) { { header: 'head', footer: 'foot', version: '1.2.3' } }
  subject { described_class.new options }

  describe '#initialize' do
    it "sets initial attribute values" do
      expect(subject.header).to eq 'head'
      expect(subject.footer).to eq 'foot'
      expect(subject.version).to eq '1.2.3'
      expect(subject.commands).to be_a Hash
    end
  end

  describe '#route' do
    it "adds a command and a handler to the commands hash" do
      subject.route "cmd", to: 'ClassConstant'
      expect(subject.commands['cmd']).to eq 'ClassConstant'
    end
  end

  describe '#route_all' do
    it "sets a global handler" do
      subject.route_all to: 'ClassConstant'
      expect(subject.handler).to eq 'ClassConstant'
    end    
  end
end
