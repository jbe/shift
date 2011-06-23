
module Shift
  class CoffeeScript < Interface

    def self.gem_dependencies
      %w{coffee-script}
    end

    def self.require_libs
      %w{coffee-script}
    end

    def self.target_format
      'js'
    end

    def initialize(opts={})
      @opts = opts
    end
    
    def process(str)
      ::CoffeeScript.compile(str, @opts)
    end

  end
end
