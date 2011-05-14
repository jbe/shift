

module Shift
  class ClosureCompiler < Interface

    def self.gem_dependencies
      %w{closure-compiler}
    end

    def self.engine_class
      Closure::Compiler
    end

    def self.target_format
      'min.js'
    end

    def process(str)
      @engine.compile(str)
    end

  end
end
