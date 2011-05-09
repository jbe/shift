
module Shift
  class CoffeeScript < Identity

    def self.gem_dependencies
      %w{coffee-script}
    end

    def self.require_libs
      %w{coffee-script}
    end

    def initialize(opts={})
      @opts = opts
    end
    

    def process_plain(str)
      ::CoffeeScript.compile(str, @opts)
    end

  end
end
