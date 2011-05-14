
module Shift
  class YUICompressor < Interface

    def self.gem_dependencies
      %w{yui-compressor}
    end

    def self.require_libs
      %w{yui/compressor}
    end

    def self.engine_class
      YUI::JavaScriptCompressor
    end

    def self.target_format
      'min.js'
    end

    def process(str)
      @engine.compress(str)
    end

  end
end
