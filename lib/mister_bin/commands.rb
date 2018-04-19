module MisterBin

  # This class handles listing and finding command files
  class Commands
    attr_reader :basename, :basedir, :isolate

    def initialize(basename, basedir='.', isolate: false)
      @basename = basename
      @basedir = basedir
      @isolate = isolate
    end

    def all
      @all ||= all!
    end

    def names
      all.keys.sort
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
        if file =~ /#{basename}-([a-z]+)-([a-z]+)\.rb/
          command = "#{$1} #{$2}"
        elsif file =~ /#{basename}-([a-z]+)\.rb/
          command = $1
        end
        result[command] = Command.new command, file
      end
      result
    end

    def files
      @files ||= path_helper.search("#{basename}-*.rb")
    end

    def path_helper
      @path_helper ||= path_helper!
    end

    def path_helper!
      helper = PathHelper.new(additional_dir: basedir)
      helper.paths = [basedir] if isolate
      helper
    end
  end
end