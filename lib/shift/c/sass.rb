module Shift
  class Sass < Identity

    def self.gem_dependencies
      %w{sass}
    end

    def initialize(opts={})
      @opts = opts
    end
    
    def process_plain(str)
      ::Sass::Engine.new(str, @opts).render
    end

  end
end
