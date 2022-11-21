require 'spec_helper'
require_relative '../samples/dir_command'

describe Command do
  subject(:command) { DirCommand.new }

  describe '#execute' do
    it 'runs the command' do
      expect { command.execute }.to output_approval('command/dir_command_usage')
    end
  end
end
