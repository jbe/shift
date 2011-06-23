module Shift
  class Sass < Interface

    def self.gem_dependencies
      %w{sass}
    end

    def self.target_format
      'css'
    end

    def initialize(opts={})
      @opts = opts
    end
    
    def process(str)
      ::Sass::Engine.new(str, @opts).render
    end

  end
end
