module MisterBin

  # This class handles listing and finding command files
  class Commands
    attr_reader :basename, :basedir

    def initialize(basename, basedir='.')
      @basename = basename
      @basedir = basedir
    end

    def all
      @all ||= all!
    end

    def names
      all.keys
    end

    def find(command, subcommand=nil)
      if subcommand and names.include? "#{command} #{subcommand}"
        all["#{command} #{subcommand}"]
      else
        all["#{command}"]
      end
    end

    private

    def all!
      result = {}
      files.map do |file|
        if file =~ /#{basename}-(.+)-(.+)\.rb/
          command = "#{$1} #{$2}"
        elsif file =~ /#{basename}-(.+)\.rb/
          command = $1
        end
        result[command] = Command.new command, file
      end
      result
    end

    def files
      @files ||= Dir["#{basedir}/#{basename}-*.rb"]
    end
  end
end