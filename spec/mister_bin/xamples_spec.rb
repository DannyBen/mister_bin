describe 'Examples' do
  Dir['examples/*'].select { |f| File.directory? f }.each do |example|
    name = File.basename(example)

    describe name do
      lines = Dir.chdir(example) { File.readlines('app.rb').filter_map { |line| line[/^# \$ (.*)/, 1] } }

      lines.each do |line|
        clean_line = line.sub('./app.rb', 'app').gsub(/[^a-zA-Z0-9 ]/, '-')
        fixture_name = "examples/#{name}/#{clean_line}"

        it "executes #{line}" do
          Dir.chdir(example) do
            expect(`#{line}`).to match_approval(fixture_name)
          end
        end
      end
    end
  end
end
