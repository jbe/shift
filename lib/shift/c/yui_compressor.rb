
module Shift
  class YUICompressor < Identity

    def self.gem_dependencies
      %w{yui-compressor}
    end

    def self.require_libs
      %w{yui/compressor}
    end

    def self.compiler_class
      YUI::JavaScriptCompressor
    end

    def process_plain(str)
      @engine.compress(str)
    end

  end
end
