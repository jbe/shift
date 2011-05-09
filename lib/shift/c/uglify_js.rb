

module Shift
  class UglifyJS < Identity

    def self.gem_dependencies
      %w{uglifier}
    end

    def self.compiler_class
      Uglifier
    end

    def process_plain(str)
      @engine.compile(str)
    end

  end
end
