

module Shift
  class ClosureCompiler < Identity

  def self.gem_dependencies
    %w{closure-compiler}
  end

  def self.compiler_class
    Closure::Compiler
  end

  def process_plain(str)
    @engine.compile(str)
  end

  end
end
