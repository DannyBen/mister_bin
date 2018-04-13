module Supersub
  class Commands
    attr_reader :basename

    def initialize(basename)
      @basename = basename
    end

    def all
      @all ||= all!
    end

    def find(query)
      keys = all.keys.select { |k| k =~ /^#{query}/ }
      keys.map { |k| [k, all[k]] }.to_h
    end

    def find_one(query)
      result = find query
      result.size == 1 ? result : false
    end

    private

    def all!
      result = {}
      files.each do |file|
        if file =~ /#{basename}-(.+)-(.+)\.rb/
          result[$1] ||= {}
          result[$1][$2] = file
        elsif file =~ /#{basename}-(.+)\.rb/
          result[$1] = file
        end
      end
      result
    end

    def files
      @files ||= Dir["#{basename}-*.rb"]
    end
  end
end