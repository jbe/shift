

#  SHIFT
#
#  Compiler and compressor interface framework
#
#  (c) 2011 Jostein Berre Eliassen - MIT licence


module Shift

  VERSION = '0.4.0'

  require 'shift/errors'
  require 'shift/mapper'
  require 'shift/interfaces'
  require 'shift/mappings'

  autoload :String,   'shift/string'


  class << self
  
    # (see Shift::String.new)
    #
    def new(*args)
      Shift::String.new(*args)
    end

    # Read a file, returning a Shift string.
    # @param [String] path the file to read from.
    # @param [String] new_path treat the shift string as if it came
    #   from this path. Can be used to override file type behavior.
    #
    # (see Shift.new)
    #
    def read(path, new_path=nil)
      new(File.read(path), new_path || path)
    end

    # Read and concatenate several files.
    # (see Shift.read)
    #
    # TODO: glob
    #
    def concat(*globs)
      buf = new('', File.extname(globs.first))
      globs.each do |glob|
        Dir[glob].each do |file|
          buf.read_append(file)
        end
      end
      buf
    end
    alias :cat :concat

  end
end

# (see Shift.new)
#
def Shift(*args)
  Shift.new(*args)
end


