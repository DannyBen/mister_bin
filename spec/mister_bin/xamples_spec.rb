require 'spec_helper'

describe 'examples' do
  it 'works' do
    dirs = Dir['examples/*'].select { |f| File.directory? f }
    # dirs = Dir["examples/06*"]

    dirs.each do |example|
      name = File.basename example

      say "g`#{name}`"

      Dir.chdir example do
        lines = File.readlines 'app.rb'
        lines = lines.filter_map { |line| line[/^# \$ (.*)/, 1] }
        lines.each do |line|
          say "b`$` #{line}"
          clean_line = line.sub('./app.rb', 'app').gsub(/[^a-zA-Z0-9 ]/, '-')
          fixture_name = "examples/#{name}/#{clean_line}"
          expect(`bundle exec #{line}`).to match_approval fixture_name
        end
      end
    end
  end
end
