require 'spec_helper'
require_relative '../samples/dir_command'
require_relative '../samples/global_command'

describe 'integration' do
  subject do
    runner = MisterBin::Runner.new version: '1.2.3',
      header: "This is a sample header.",
      footer: "This is a sample footer.\nUse --help for each command to get more information"

    runner.route 'dir', to: DirCommand
    runner
  end

  it "shows header, footer and subcommands" do
    expect{ subject.run }.to output_approval('integration/without-args')
  end

  context "with unknown command" do
    it "shows an error and subcommands" do
      expect{ subject.run ["no-such-command"] }.to output_approval('integration/unknown') 
    end
  end

  context "with --version" do
    it "shows primary version number" do
      expect{ subject.run ["--version"] }.to output_approval('integration/version') 
    end
  end

  context "with --help", :focus do
    it "shows all commands and their long description" do
      expect{ subject.run ["--help"] }.to output_approval('integration/help') 
    end

    context "when no subcommands are defined" do
      subject { MisterBin::Runner.new }

      it "errors gracefully" do
        expect{ subject.run ['--help'] }.to output_approval('integration/no-subcommands') 
      end
    end
  end

  context "with subcommand" do
    it "executes the subcommand" do
      expect{ subject.run ["dir"] }.to output_approval('integration/dir') 
    end
  end

  context "with subcommand --help" do
    it "shows the help of the subcommand" do
      expect{ subject.run ["dir", "--help"] }.to output_approval('integration/dir-help') 
    end
  end

  context "with subcommand --version" do
    it "shows the version of the subcommand" do
      expect{ subject.run ["dir", "--version"] }.to output_approval('integration/dir-version') 
    end
  end

  context "when no subcommands are defined" do
    subject { MisterBin::Runner.new }

    it "errors gracefully" do
      expect{ subject.run }.to output_approval('integration/no-subcommands') 
    end
  end

  context "when using a global handler" do
    subject { MisterBin::Runner.new handler: GlobalCommand }

    it "sends all requests to the global handler" do
      expect{ subject.run }.to output_approval('integration/global-usage')
    end

    it "calls #run" do
      expect{ subject.run 'greet Luke' }.to output_approval('integration/global-run')
    end
  end

end