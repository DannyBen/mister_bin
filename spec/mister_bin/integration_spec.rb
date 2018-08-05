require 'spec_helper'
require_relative '../../example/dir_command'

describe 'integration' do
  subject do
    runner = MisterBin::Runner.new version: '1.2.3',
      header: "This is a sample header.",
      footer: "This is a sample footer.\nUse --help for each command to get more information"

    runner.route 'dir', to: DirCommand
    runner
  end

  it "shows header, footer and subcommands" do
    expect{ subject.run }.to output_fixture('integration/without-args')
  end

  context "with unknown command" do
    it "shows an error and subcommands" do
      expect{ subject.run ["no-such-command"] }.to output_fixture('integration/unknown') 
    end
  end

  context "with --version" do
    it "shows primary version number" do
      expect{ subject.run ["--version"] }.to output_fixture('integration/version') 
    end
  end

  context "with subcommand" do
    it "executes the subcommand" do
      expect{ subject.run ["dir"] }.to output_fixture('integration/dir') 
    end
  end

  context "with subcommand --help" do
    it "shows the help of the subcommand" do
      expect{ subject.run ["dir", "--help"] }.to output_fixture('integration/dir-help') 
    end
  end

  context "with subcommand --version" do
    it "shows the version of the subcommand" do
      expect{ subject.run ["dir", "--version"] }.to output_fixture('integration/dir-version') 
    end
  end

  context "when no subcommands are defined" do
    subject do
      MisterBin::Runner.new version: '3.7.7.0.7'
    end

    it "shows an error" do
      expect{ subject.run }.to output_fixture('integration/no-subcommands') 
    end
  end

end