require 'spec_helper'

describe Runner do
  let(:name) { 'app' }
  let(:opts) {{ 
    basedir: 'spec/workspace', 
    header: '!txtgrn!Header', 
    footer: 'The !txtred!End' 
  }}
  
  subject { described_class.new name, opts }

  describe '#run' do
    context "with empty argv" do
      it "shows subcommands" do
        expect{ subject.run }.to output_fixture('runner/run')
      end
    end

    context "with --version" do
      context "when version was provided" do
        let(:opts) {{ 
          basedir: 'spec/workspace', 
          version: '7.7.7' 
        }}

        it "shows version number" do
          expect{ subject.run ['--version'] }.to output_fixture('runner/run-version')
        end
      end

      context "when version was not provided" do
        let(:opts) {{ 
          basedir: 'spec/workspace', 
        }}

        it "treats it as a normal unknown command" do
          expect{ subject.run ['--version'] }.to output_fixture('runner/run-no-version')
        end
      end
    end

    context "with arguments" do
      it "executes the command" do
        expect{ subject.run ['ls'] }.to output_fixture('runner/run-ls')
      end
    end

    context "with an unknown command" do
      it "executes the command" do
        expect{ subject.run ['unknown'] }.to output_fixture('runner/run-unknown')
      end
    end

    context "when no subcommands are fonud" do
      let(:name) { 'nosuchcommand' }

      it "errors gracefully" do
        expect{ subject.run }.to output_fixture('runner/run-no-subs')
      end
    end

    context "path isolation" do
      before :all do
        # Make the 'spec/workspace' a part of the system search PATH
        @path = ENV['PATH']
        ENV['PATH'] = "spec/workspace" + File::PATH_SEPARATOR + ENV['PATH']
      end

      after :all do
        ENV['PATH'] = @path
      end

      context "when isolate=false" do
        let(:opts) {{ basedir: 'spec/workspace/somedir' }}

        it "shows commands in path and in basedir" do
          expect{ subject.run }.to output_fixture('runner/isolate-false')
        end
      end

      context "when isolate=true" do
        let(:opts) {{ basedir: 'spec/workspace/somedir', isolate: true }}

        it "shows commands in basedir only" do
          expect{ subject.run }.to output_fixture('runner/isolate-true')
        end
      end
      
    end
  end

end
