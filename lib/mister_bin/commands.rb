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

    def find(query)
      query = [query] unless query.is_a? Array
      query_regex = /^#{query.join '.* '}/
      keys = names.select { |k| k =~ /^#{query_regex}/ }
      keys = names.select { |k| k =~ /^#{query.first}/ } if keys.empty?
      keys.map { |k| [k, all[k]] }.to_h
    end

    def find_one(query)
      result = find query
      result.size == 1 ? result.values.first : false
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