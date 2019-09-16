require 'spec_helper'

describe 'examples' do
  it "works" do
    dirs = Dir['examples/*'].select { |f| File.directory? f }
    # dirs = Dir["examples/06*"]

    dirs.each do |example|
      name = File.basename example
      result = nil
      
      say "!txtgrn!#{name}"

      Dir.chdir example do
        lines = File.readlines "app.rb"
        lines = lines.map { |line| line[/^# \$ (.*)/, 1] }.compact
        lines.each do |line|
          say "!txtblu!$!txtrst! #{line}"
          clean_line = line.sub('./app.rb', 'app').gsub(/[^a-zA-Z0-9 ]/, '-')
          fixture_name = "examples/#{name}/#{clean_line}"
          expect(`bundle exec #{line}`).to match_fixture fixture_name
        end
      end
    end
  end  
end
