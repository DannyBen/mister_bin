module MisterBin

  class PathHelper
    attr_reader :pathspec, :additional_dir

    def initialize(additional_dir: nil, pathspec: nil)
      @additional_dir = additional_dir
      @pathspec = pathspec || ENV['PATH']
    end

    def search(glob)
      result = []
      paths.each { |path| result += Dir["#{path}/#{glob}"] }
      result
    end

    def paths
      @paths ||= paths!
    end

    private

    def paths!
      result = pathspec.split File::PATH_SEPARATOR
      result.push additional_dir if additional_dir
      result
    end
  end
end