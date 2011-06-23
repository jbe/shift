

module Shift
  class UglifyJS < Interface

    def self.gem_dependencies
      %w{uglifier}
    end

    def self.engine_class
      Uglifier
    end

    def self.target_format
      'min.js'
    end

    def process(str)
      @engine.compile(str)
    end

  end
end
