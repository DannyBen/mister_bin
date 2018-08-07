require 'spec_helper'

describe 'examples' do
  it "works" do
    dirs = Dir['examples/*'].select { |f| File.directory? f }

    # dirs = Dir["examples/06*"]

    dirs.each do |example|
      name = File.basename example
      result = nil
      
      puts "--> #{name}"

      Dir.chdir example do
        expect(`bundle exec ./runme`).to match_fixture("examples/#{name}")
      end
    end
  end  
end
